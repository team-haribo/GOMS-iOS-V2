import UIKit

class FilterBottomSheetViewController: UIViewController {
    enum BottomSheetViewState {
        case expanded
        case normal
    }
    
    private lazy var dimmedView = UIView()
    
    private lazy var bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.cornerCurve = .continuous
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    var defaultHeight: CGFloat = 500
    var dimmedAlpha: CGFloat = 0.45
    
    private lazy var bottomSheetPanStartingTopConstant: CGFloat = 40
    
    private let contentViewController: UIViewController
    
    private lazy var bottomSheetContentVC = FilterBottomSheetContentViewController().then {
        $0.buttonAction = { [weak self] in
            self?.hideBottomSheetAndGoBack()
        }
    }
    
    init(contentViewController: UIViewController, defaultHeight: CGFloat, dimmedAlpha: CGFloat = 0.4) {
        self.contentViewController = contentViewController
        self.defaultHeight = defaultHeight
        self.dimmedAlpha = dimmedAlpha
        
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black.withAlphaComponent(0.45)
        
        self.configureUI()
        self.configureLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showBottomSheet()
        
        configureBottomSheetContent()
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
                self.bottomSheetViewTopConstraint.constant = self.bottomSheetPanStartingTopConstant
            }
            
        } else {
            self.bottomSheetViewTopConstraint.constant = self.bottomSheetPanStartingTopConstant
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.dimmedView.alpha = self.dimAlphaWithBottomSheetTopConstraint(value: 0.45)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: Configure
extension FilterBottomSheetViewController {
    private func configureUI() {
        [dimmedView, bottomSheetView].forEach {
            view.addSubview($0)
        }
        
        addChild(contentViewController)
        bottomSheetView.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
    }
    
    private func configureLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint,
        ])
        
        contentViewController.view.snp.makeConstraints {
            $0.edges.equalTo(bottomSheetView)
        }
    }
    
    // MARK: Add BottomSheetContent
    private func configureBottomSheetContent() {
        addChild(bottomSheetContentVC)
        bottomSheetView.addSubview(bottomSheetContentVC.view)
        bottomSheetContentVC.didMove(toParent: self)
        
        bottomSheetContentVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension FilterBottomSheetViewController {
    public func hideBottomSheetAndGoBack() {
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
