//
//  AdminMenuDataList.swift
//  Feature
//
//  Created by 새미 on 4/29/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import UIKit

final class AdminMenuDataList {
    
    private var adminMenuArray: [AdminMenu] = []
    
    func makeAdminMenuData() {
        adminMenuArray = [
            AdminMenu(icon: .image.qrIcon.image, title: "QR 생성"),
            AdminMenu(icon: .image.studentCouncilIcon.image, title: "학생 관리"),
            AdminMenu(icon: .image.outingStatusIcon.image, title: "외출 현황"),
            AdminMenu(icon: .image.lateIcon.image, title: "지각자 명단"),
            AdminMenu(icon: .image.settingIcon.image, title: "개인 설정")
        ]
    }
    
    func getAdminMenuData() -> [AdminMenu] {
        self.makeAdminMenuData()
        return adminMenuArray
    }
}
