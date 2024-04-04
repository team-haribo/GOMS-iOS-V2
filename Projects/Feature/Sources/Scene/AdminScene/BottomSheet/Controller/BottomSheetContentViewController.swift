import UIKit

class BottomSheetContentViewController: BaseViewController {
    private let titleText = UILabel().then {
        $0.text = "필터"
        $0.font = UIFont.pretendard(size: 19, weight: .bold)
    }
    
    private let closeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
    }
    
    private let roleView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 375, height: 112)
        $0.backgroundColor = .clear
    }
    
    private let roleTitle = UILabel().then {
        $0.text = "역할"
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }

    private let roleStudentButton = UIButton(filterButton: "학생")
    
    private let roleStudentCouncilButton = UIButton(filterButton: "학생회")
    
    private let roleOutingProhibitionButton = UIButton(filterButton: "외출 금지")
    
    private let gradeView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 375, height: 112)
        $0.backgroundColor = .clear
    }
    
    private let gradeTitle = UILabel().then {
        $0.text = "학년"
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    private let firstGradeButton = UIButton(filterButton: "1학년")
    
    private let secondGradeButton = UIButton(filterButton: "2학년")
    
    private let thirdGradeButton = UIButton(filterButton: "3학년")
    
    private let genderView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 375, height: 112)
        $0.backgroundColor = .clear
    }
    
    private let genderTitle = UILabel().then {
        $0.text = "성별"
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    private let maleButton = UIButton(filterButton: "남성")
    
    private let femaleButton = UIButton(filterButton: "여성")
    
    private let departmentView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 375, height: 112)
        $0.backgroundColor = .clear
    }
    
    private let departmentTitle = UILabel().then {
        $0.text = "학과"
        $0.font = UIFont.pretendard(size: 19, weight: .semibold)
    }
    
    private let swButton = UIButton(filterButton: "SW")
    
    private let iotButton = UIButton(filterButton: "IoT")
    
    private let aiButton = UIButton(filterButton: "AI")
    
    private let filterResetButton = UIButton(filterButton: "필터 초기화").then {
        $0.setTitleColor(.color.gomsNegative.color, for: .normal)
        $0.backgroundColor = .color.gomsNegative.color.withAlphaComponent(0.25)
        $0.layer.borderColor = UIColor.clear.cgColor
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
            $0.top.equalTo(titleText.snp.bottom).offset(16)
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
    @objc func closeButtonDidTap(_ sender: Any) {
        print("닫힘")
    }
    
    @objc func roleStudentButtonDidTap(_ sender: Any) {
        print("버튼이 눌렸습니다!")
        
        roleStudentButton.backgroundColor = .color.gomsAdmin.color.withAlphaComponent(0.25)
        roleStudentButton.setTitleColor(.color.gomsAdmin.color, for: .normal)
    }
}
