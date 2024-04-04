import UIKit

import SnapKit
import Then

class BottomSheetViewController: UIViewController {
    enum BottomSheetViewState {
        case expanded
        case normal
    }
    
    private lazy var dimmedView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(self.dimmedAlpha)
        $0.alpha = 0
    }
    
    private lazy var bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = self.cornerRedius
        $0.layer.cornerCurve = .continuous
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    var defaultHeight: CGFloat = 650
    var cornerRedius: CGFloat = 12
    var dimmedAlpha: CGFloat = 0.45
    var bottomSheetPanMinTopConstant: CGFloat = 40
    var isPannedable: Bool = false
    private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
    
    private let contentViewController: UIViewController
    
    private lazy var bottomSheetContentVC = BottomSheetContentViewController()
    
    init(contentViewController: UIViewController, defaultHeight: CGFloat, cornerRadius: CGFloat = 16, dimmedAlpha: CGFloat = 0.45, isPannedable: Bool = false) {
        self.contentViewController = contentViewController
        self.defaultHeight = defaultHeight
        self.cornerRedius = cornerRadius
        self.dimmedAlpha = dimmedAlpha
        self.isPannedable = isPannedable
        
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.configureLayout()
        
        if isPannedable {
            self.configureViewPannedGesture()
        }
        
        configureBottomSheetContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showBottomSheet()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { [weak self] _ in
            self?.showBottomSheet()
        }
    }
    
    private func showBottomSheet(atState: BottomSheetViewState = .normal) {
        if atState == .normal {
            let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding: CGFloat = view.safeAreaInsets.bottom
            let constraintValue = (safeAreaHeight + bottomPadding) - defaultHeight
            
            if constraintValue > 0 {
                self.bottomSheetViewTopConstraint.constant = constraintValue
            } else {
                self.bottomSheetViewTopConstraint.constant = self.bottomSheetPanMinTopConstant
            }
            
        } else {
            self.bottomSheetViewTopConstraint.constant = self.bottomSheetPanMinTopConstant
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.dimmedView.alpha = self.dimAlphaWithBottomSheetTopConstraint(value: self.bottomSheetViewTopConstraint.constant)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func configureBottomSheetContent() {
        addChild(bottomSheetContentVC)
        bottomSheetView.addSubview(bottomSheetContentVC.view)
        bottomSheetContentVC.didMove(toParent: self)
        
        bottomSheetContentVC.view.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: Configure
extension BottomSheetViewController {
    private func configureUI() {
        [dimmedView, bottomSheetView].forEach {
            view.addSubview($0)
        }
        
        addChild(contentViewController)
        bottomSheetView.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
        bottomSheetView.clipsToBounds = true
    }
    
    private func configureLayout() {
        dimmedView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
//         MARK: Layout 깨짐 경고를 제거하고자 하는 경우 bottomSheetView의 heightAnchor 값을 지정하면 해결된다.
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor), // MARK: 이부분으로 인해 Layout 깨짐 경고가 뜬다
            bottomSheetViewTopConstraint,
        ])
        
        contentViewController.view.snp.makeConstraints {
            $0.edges.equalTo(bottomSheetView)
        }
    }
    
    private func configureViewPannedGesture() {
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        view.addGestureRecognizer(viewPan)
    }
}

// MARK: Gesture
extension BottomSheetViewController {
    // 드래그 시 실행
    @objc private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: view)
        
        let velocity = panGestureRecognizer.velocity(in: view)
        
        switch panGestureRecognizer.state {
        case .began:
            bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
        case .changed:
            if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
                bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant + translation.y
            }
            
            dimmedView.alpha = dimAlphaWithBottomSheetTopConstraint(value: bottomSheetViewTopConstraint.constant)
        case .ended:
            if velocity.y > 1500 {
                hideBottomSheetAndGoBack()
                return
            }
            
            let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding = view.safeAreaInsets.bottom
            let defaultPadding = safeAreaHeight+bottomPadding - defaultHeight
            
            let nearestValue = nearest(to: bottomSheetViewTopConstraint.constant, inValues: [bottomSheetPanMinTopConstant, defaultPadding, safeAreaHeight + bottomPadding])
            
            if nearestValue == bottomSheetPanMinTopConstant {
                showBottomSheet(atState: .expanded)
            } else if nearestValue == defaultPadding {
                showBottomSheet(atState: .normal)
            } else {
                hideBottomSheetAndGoBack()
            }
        default:
            break
        }
    }
}

extension BottomSheetViewController {
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    private func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
        guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
        else { return number }
        return nearestVal
    }
    
    private func dimAlphaWithBottomSheetTopConstraint(value: CGFloat) -> CGFloat {
        let fullDimAlpha: CGFloat = self.dimmedAlpha
        
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        let fullDimPosition = (safeAreaHeight + bottomPadding - defaultHeight) / 2
    
        let noDimPosition = safeAreaHeight + bottomPadding
    
        if value < fullDimPosition {
            return fullDimAlpha
        }

        if value > noDimPosition {
            return 0.0
        }

        return fullDimAlpha * (1 - ((value - fullDimPosition) / (noDimPosition - fullDimPosition)))
    }
}

