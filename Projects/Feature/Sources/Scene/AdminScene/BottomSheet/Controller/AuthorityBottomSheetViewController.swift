import UIKit
import SnapKit
import Then

final class AuthorityBottomSheetViewController: UIViewController {
    enum BottomSheetViewState {
        case expanded
        case normal
    }
    
    private lazy var filterDimmedView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(self.dimmedAlpha)
        $0.alpha = 0
    }
    
    let filterBottomSheetView = UIView().then {
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
    
    private lazy var bottomSheetContentVC = AuthorityBottomSheetContentViewController().then {
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
            self.filterDimmedView.alpha = self.dimAlphaWithBottomSheetTopConstraint(value: self.bottomSheetViewTopConstraint.constant)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: - Configure
extension AuthorityBottomSheetViewController {
    private func configureUI() {
        [filterDimmedView, filterBottomSheetView].forEach {
            view.addSubview($0)
        }
        
        addChild(contentViewController)
        filterDimmedView.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
    }
    
    private func configureLayout() {
        filterDimmedView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        filterBottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = filterBottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            filterBottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filterBottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filterBottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint,
        ])
        
        contentViewController.view.snp.makeConstraints {
            $0.edges.equalTo(filterBottomSheetView)
        }
    }
    
    // MARK: - Add BottomSheetContent
    private func configureBottomSheetContent() {
        addChild(bottomSheetContentVC)
        filterBottomSheetView.addSubview(bottomSheetContentVC.view)
        bottomSheetContentVC.didMove(toParent: self)
        
        bottomSheetContentVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension AuthorityBottomSheetViewController {
    public func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.filterDimmedView.alpha = 0.0
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
