//
//  Const.swift
//  Socket-Connection
//
//  Created by HumbertCheung on 2020/4/24.
//  Copyright © 2019 Humbert Cheung. All rights reserved.
//

/*
 * 全局共享文件
 */

import Foundation
import UIKit

/// 屏幕宽度
let S_Width = UIScreen.main.bounds.size.width
/// 屏幕高度
let S_Height = UIScreen.main.bounds.size.height


// 判断是否是ipad
let isPad = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
// 判断是否是iPhone X
let IS_IPHONE_X = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) && !isPad : false)
// 判断是否是iPhone Xr
let IS_IPHONE_Xr = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 828, height: 1792).equalTo((UIScreen.main.currentMode?.size)!) && !isPad : false)
// 判断是否是iPhone Xs
let IS_IPHONE_Xs = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) && !isPad : false)
// 判断是否是iPhone Xs Max
let IS_IPHONE_Xs_Max = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2688).equalTo((UIScreen.main.currentMode?.size)!) && !isPad : false)


// 判断 X 系列的状态栏，X系列：44 非X系列：20
let H_StatusBar = ((IS_IPHONE_X == true || IS_IPHONE_Xr == true || IS_IPHONE_Xs == true || IS_IPHONE_Xs_Max == true) ? 44.0 : 20.0)
// 判断 X 系列的导航栏，X系列：88 非X系列：64
let H_NavBar = ((IS_IPHONE_X == true || IS_IPHONE_Xr == true || IS_IPHONE_Xs == true || IS_IPHONE_Xs_Max == true) ? 88.0 : 64.0)
// 判断 X 系列的Tabbar，X系列：83 非X系列：49
let H_TabBar =  ((IS_IPHONE_X == true || IS_IPHONE_Xr == true || IS_IPHONE_Xs == true || IS_IPHONE_Xs_Max == true) ? 83.0 : 49.0)

// 导航栏、标签栏文本颜色
let CUSTOM_BarColor = UIColor(red: 59/255.0, green: 57/255.0, blue: 59/255.0, alpha: 1.0)

//let BaseURL = "http://127.0.0.1:8080/TempProject/Recipes/"
//
//let BaseURL = "http://localhost:8080/TempProject/Recipes/"

let BaseURL = "http://118.31.76.212/TempProject/Recipes/"

let ImageBaseURL = "\(BaseURL)img/"
