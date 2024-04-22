import UIKit

class FilterBottomSheetContentViewController: BaseViewController {
    private let titleText = UILabel().then {
        $0.text = "필터"
        $0.font = UIFont.pretendard(size: 19, weight: .bold)
    }
    
    private let closeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .color.gomsTextDefault.color
        $0.addTarget(self, action: #selector(closeButtonDidTap(_:)), for: .touchUpInside)
    }
    
    var buttonAction: (() -> Void)?
    
    private let roleView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 375, height: 112)
        $0.backgroundColor = .clear
    }
    
    private let roleTitle = UILabel().then {
        $0.text = "역할"
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }

    private var isRoleStudentButtonSelected = false
    private let roleStudentButton = UIButton(filterButton: "학생").then {
        $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
        $0.addTarget(self, action: #selector(roleStudentButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private var isRoleStudentCouncilButtonSelected = false
    private let roleStudentCouncilButton = UIButton(filterButton: "학생회").then {
        $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
        $0.addTarget(self, action: #selector(roleStudentCouncilButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private var isRoleOutingProhibitionButtonSelected = false
    private let roleOutingProhibitionButton = UIButton(filterButton: "외출 금지").then {
        $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
        $0.addTarget(self, action: #selector(roleOutingProhibitionButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private let gradeView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 375, height: 112)
        $0.backgroundColor = .clear
    }
    
    private let gradeTitle = UILabel().then {
        $0.text = "학년"
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    private var isFristGradeButtonSelected = false
    private let firstGradeButton = UIButton(filterButton: "1학년").then {
        $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
        $0.addTarget(self, action: #selector(firstGradeButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private var isSecondGradeButtonSelected = false
    private let secondGradeButton = UIButton(filterButton: "2학년").then {
        $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
        $0.addTarget(self, action: #selector(secondGradeButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private var isThirdeGradeButtonSelected = false
    private let thirdGradeButton = UIButton(filterButton: "3학년").then {
        $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
        $0.addTarget(self, action: #selector(thirdGradeButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private let genderView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 375, height: 112)
        $0.backgroundColor = .clear
    }
    
    private let genderTitle = UILabel().then {
        $0.text = "성별"
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    private var isMaleButtonSelected = false
    private let maleButton = UIButton(filterButton: "남성").then {
        $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
        $0.addTarget(self, action: #selector(maleButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private var isFemaleButtonSelected = false
    private let femaleButton = UIButton(filterButton: "여성").then {
        $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
        $0.addTarget(self, action: #selector(femaleButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private let departmentView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 375, height: 112)
        $0.backgroundColor = .clear
    }
    
    private let departmentTitle = UILabel().then {
        $0.text = "학과"
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    private var isSwButtonSelected = false
    private let swButton = UIButton(filterButton: "SW").then {
        $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
        $0.addTarget(self, action: #selector(swButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private var isIotButtonSelected = false
    private let iotButton = UIButton(filterButton: "IoT").then {
        $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
        $0.addTarget(self, action: #selector(iotButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private var isAiButtonSelected = false
    private let aiButton = UIButton(filterButton: "AI").then {
        $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
        $0.addTarget(self, action: #selector(aiButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private let filterResetButton = UIButton(filterButton: "필터 초기화").then {
        $0.setTitleColor(.color.gomsNegative.color, for: .normal)
        $0.backgroundColor = .color.gomsNegative.color.withAlphaComponent(0.25)
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.addTarget(self, action: #selector(filterResetButtonDidTap(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addView() {
        [titleText, closeButton, roleView, gradeView, genderView, departmentView, filterResetButton].forEach {
            view.addSubview($0)
        }
        
        [roleTitle, roleStudentButton, roleStudentCouncilButton, roleOutingProhibitionButton].forEach {
            roleView.addSubview($0)
        }
        
        [gradeTitle, firstGradeButton, secondGradeButton, thirdGradeButton].forEach {
            gradeView.addSubview($0)
        }
        
        [genderTitle, maleButton, femaleButton].forEach {
            genderView.addSubview($0)
        }
        
        [departmentTitle, swButton, iotButton, aiButton].forEach {
            departmentView.addSubview($0)
        }
    }
    
    override func setLayout() {
        titleText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        roleView.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.height.equalTo(112)
            $0.top.equalToSuperview().offset(64)
            $0.leading.trailing.equalToSuperview()
        }
        
        roleTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(20)
        }
        
        roleStudentButton.snp.makeConstraints {
            $0.width.equalTo(101)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(roleStudentCouncilButton.snp.leading).offset(-16)
        }
        
        roleStudentCouncilButton.snp.makeConstraints {
            $0.width.equalTo(101)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(roleStudentButton.snp.trailing).offset(16)
            $0.trailing.equalTo(roleOutingProhibitionButton.snp.leading).offset(-16)
        }
        
        roleOutingProhibitionButton.snp.makeConstraints {
            $0.width.equalTo(101)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(roleStudentCouncilButton.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        gradeView.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.height.equalTo(112)
            $0.top.equalTo(roleView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        gradeTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(20)
        }
        
        firstGradeButton.snp.makeConstraints {
            $0.width.equalTo(101)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(secondGradeButton.snp.leading).offset(-16)
        }
        
        secondGradeButton.snp.makeConstraints {
            $0.width.equalTo(101)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(firstGradeButton.snp.trailing).offset(16)
            $0.trailing.equalTo(thirdGradeButton.snp.leading).offset(-16)
        }
        
        thirdGradeButton.snp.makeConstraints {
            $0.width.equalTo(101)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(secondGradeButton.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        genderView.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.height.equalTo(112)
            $0.top.equalTo(gradeView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        genderTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(20)
        }
        
        maleButton.snp.makeConstraints {
            $0.width.equalTo(159)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(femaleButton.snp.leading).offset(-16)
        }
        
        femaleButton.snp.makeConstraints {
            $0.width.equalTo(159)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(maleButton.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        departmentView.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.height.equalTo(112)
            $0.top.equalTo(genderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        departmentTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(20)
        }
        
        swButton.snp.makeConstraints {
            $0.width.equalTo(101)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(iotButton.snp.leading).offset(-16)
        }
        
        iotButton.snp.makeConstraints {
            $0.width.equalTo(101)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(swButton.snp.trailing).offset(16)
            $0.trailing.equalTo(aiButton.snp.leading).offset(-16)
        }
        
        aiButton.snp.makeConstraints {
            $0.width.equalTo(101)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(iotButton.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        filterResetButton.snp.makeConstraints {
            $0.width.equalTo(319)
            $0.height.equalTo(56)
            $0.top.equalTo(departmentView.snp.bottom).offset(24)
            $0.bottom.equalToSuperview().inset(58)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: Action
    @objc private func closeButtonDidTap(_ sender: Any) {
        buttonAction?()
    }
    
    @objc private func roleStudentButtonDidTap(_ sender: Any) {
        isRoleStudentButtonSelected.toggle()
        
        if isRoleStudentButtonSelected {
            print("학생 버튼이 눌렸습니다!")
            roleStudentButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
            roleStudentButton.layer.borderColor = UIColor.clear.cgColor
            roleStudentButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
        } else {
            print("학생 버튼이 해제되었습니다!")
            roleStudentButton.backgroundColor = .clear
            roleStudentButton.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            roleStudentButton.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
    
    @objc private func roleStudentCouncilButtonDidTap(_ sender: Any) {
        isRoleStudentCouncilButtonSelected.toggle()
        
        if isRoleStudentCouncilButtonSelected {
            print("학생회 버튼이 눌렸습니다!")
            roleStudentCouncilButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
            roleStudentCouncilButton.layer.borderColor = UIColor.clear.cgColor
            roleStudentCouncilButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
        } else {
            print("학생회 버튼이 해제되었습니다!")
            roleStudentCouncilButton.backgroundColor = .clear
            roleStudentCouncilButton.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            roleStudentCouncilButton.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
    
    @objc private func roleOutingProhibitionButtonDidTap(_ sender: Any) {
        isRoleOutingProhibitionButtonSelected.toggle()
        
        if isRoleOutingProhibitionButtonSelected {
            print("외출금지 버튼이 눌렸습니다!")
            roleOutingProhibitionButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
            roleOutingProhibitionButton.layer.borderColor = UIColor.clear.cgColor
            roleOutingProhibitionButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
        } else {
            print("외출금지 버튼이 해제되었습니다!")
            roleOutingProhibitionButton.backgroundColor = .clear
            roleOutingProhibitionButton.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            roleOutingProhibitionButton.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
    
    @objc private func firstGradeButtonDidTap(_ sender: Any) {
        isFristGradeButtonSelected.toggle()
        
        if isFristGradeButtonSelected {
            print("1학년 버튼이 눌렸습니다!")
            firstGradeButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
            firstGradeButton.layer.borderColor = UIColor.clear.cgColor
            firstGradeButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
        } else {
            print("1학년 버튼이 해제되었습니다!")
            firstGradeButton.backgroundColor = .clear
            firstGradeButton.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            firstGradeButton.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
    
    @objc private func secondGradeButtonDidTap(_ sender: Any) {
        isSecondGradeButtonSelected.toggle()
        
        if isSecondGradeButtonSelected {
            print("2학년 버튼이 눌렸습니다!")
            secondGradeButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
            secondGradeButton.layer.borderColor = UIColor.clear.cgColor
            secondGradeButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
        } else {
            print("2학년 버튼이 해제되었습니다!")
            secondGradeButton.backgroundColor = .clear
            secondGradeButton.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            secondGradeButton.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
    
    @objc private func thirdGradeButtonDidTap(_ sender: Any) {
        isThirdeGradeButtonSelected.toggle()
        
        if isThirdeGradeButtonSelected {
            print("3학년 버튼이 눌렸습니다!")
            thirdGradeButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
            thirdGradeButton.layer.borderColor = UIColor.clear.cgColor
            thirdGradeButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
        } else {
            print("3학년 버튼이 해제되었습니다!")
            thirdGradeButton.backgroundColor = .clear
            thirdGradeButton.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            thirdGradeButton.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
    
    @objc private func maleButtonDidTap(_ sender: Any) {
        isMaleButtonSelected.toggle()
        
        if isMaleButtonSelected {
            print("남성 버튼이 눌렸습니다!")
            maleButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
            maleButton.layer.borderColor = UIColor.clear.cgColor
            maleButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
        } else {
            print("남성 버튼이 해제되었습니다!")
            maleButton.backgroundColor = .clear
            maleButton.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            maleButton.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
    
    @objc private func femaleButtonDidTap(_ sender: Any) {
        isFemaleButtonSelected.toggle()
        
        if isFemaleButtonSelected {
            print("여성 버튼이 눌렸습니다!")
            femaleButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
            femaleButton.layer.borderColor = UIColor.clear.cgColor
            femaleButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
        } else {
            print("여성 버튼이 해제되었습니다!")
            femaleButton.backgroundColor = .clear
            femaleButton.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            femaleButton.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
    
    @objc private func swButtonDidTap(_ sender: Any) {
        isSwButtonSelected.toggle()
        
        if isSwButtonSelected {
            print("SW 버튼이 눌렸습니다!")
            swButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
            swButton.layer.borderColor = UIColor.clear.cgColor
            swButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
        } else {
            print("SW 버튼이 해제되었습니다!")
            swButton.backgroundColor = .clear
            swButton.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            swButton.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
    
    @objc private func iotButtonDidTap(_ sender: Any) {
        isIotButtonSelected.toggle()
        
        if isIotButtonSelected {
            print("IoT 버튼이 눌렸습니다!")
            iotButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
            iotButton.layer.borderColor = UIColor.clear.cgColor
            iotButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
        } else {
            print("IoT 버튼이 해제되었습니다!")
            iotButton.backgroundColor = .clear
            iotButton.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            iotButton.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
    
    @objc private func aiButtonDidTap(_ sender: Any) {
        isAiButtonSelected.toggle()
        
        if isAiButtonSelected {
            print("AI 버튼이 눌렸습니다!")
            aiButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
            aiButton.layer.borderColor = UIColor.clear.cgColor
            aiButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
        } else {
            print("AI 버튼이 해제되었습니다!")
            aiButton.backgroundColor = .clear
            aiButton.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            aiButton.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
    
    @objc private func filterResetButtonDidTap(_ sender: Any) {
        [roleStudentButton, roleStudentCouncilButton, roleOutingProhibitionButton, firstGradeButton, secondGradeButton, thirdGradeButton, maleButton, femaleButton, swButton, iotButton, aiButton].forEach {
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.color.gomsBottomSheetBorder.color.cgColor
            $0.setTitleColor(.color.gomsSecondary.color, for: .normal)
        }
    }
}
