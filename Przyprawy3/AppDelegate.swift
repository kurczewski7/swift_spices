//
//  AppDelegate.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 20.07.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData


let coreData = CoreDataStack()
let database = Database(context: coreData.persistentContainer.viewContext)

let picturesArray: [String] =
    ["CYKORIA_ARROD_PAPRYKA_OSTRA_MIELONA_10G_59954826_0_173_200","CYKORIA_ARROD_PIEPRZ_CZARNY_ZIARNISTY_11G_60057064_0_173_200",
     "CYKORIA_ARROD_PRZYPRAWA_DO_KURCZAKA_20G_60194487_0_173_200","CYKORIA_BAZYLIA_CYKORIA_10_g_60066362_0_173_200",
     "CYKORIA_CHILI_20G_CYKORIA_60002862_0_173_200","CYKORIA_CURRY_25G_CYKORIA_60114196_0_173_200",
     "CYKORIA_CYNAMON_MIELONY_20G_CYKORIA_63402101_0_173_200","CYKORIA_CZOSNEK_SUSZONY_GRANULOWANY_20G_CYKORIA_60103033_0_173_200",
     "CYKORIA_ESTRAGON_10G_CYKORIA_60920808_0_173_200","CYKORIA_GALKA_MUSZKATOLOWA_MIELONA_15G_61107553_0_173_200",
     "CYKORIA_GORCZYCA_CYKORIA_25_g_60223088_0_173_200","CYKORIA_IMBIR_MIELONY_20G_CYKORIA_60955721_0_173_200",
     "CYKORIA_Jalowiec_15g_53445060_0_173_200","CYKORIA_KMINEK_20G_CYKORIA_59584029_0_173_200",
     "CYKORIA_KOLENDRA_MIELONA_20G_CYKORIA_60947785_0_173_200","Dr_Oetker_Dr_Oetker_Przyprawa_korzenna_40g_76415553_0_173_200",   "Kamis_Aromatyczny_Pstrag_Z_Koperkiem_18g_35965474_0_173_200","Kamis_FAMILY_MAJERANEK_18G_87417754_0_173_200","Kamis_FAMILY_PAPRYKA_SLODKA_50G_87681805_0_173_200","Kamis_FAMILY_PIEPRZ_ZIOLOWY_50G_87295275_0_173_200","Kamis_FAMILY_PRZYPRAWA_DO_GYROSA_70G_87450078_0_173_200","Kamis_FAMILY_PRZYPRAWA_DO_KURCZAKA_75G_87502506_0_173_200","Kamis_FAMILY_ZIOLA_PROWANSALSKIE_25G_87347761_0_173_200","Kamis_GRILL_CHRUPIACE_WARZYWA_39225271_0_173_200","Kamis_GRILL_KASZANKA_Z_CEBULKA_39501788_0_173_200","Kamis_Grill_Srodziemnomorski_20g_37625365_0_173_200","Kamis_GRILL_ZIEMNIAKI_PIECZONE_39513239_0_173_200","Kamis_KAM_KOPEREK_6G_62938774_0_173_200","Kamis_KAM_OREGANO_10G_61704995_0_173_200","Kamis_KAM_PRZYP_DO_DAN_MEKSYK_25G_62277777_0_173_200","Kamis_KAM_PRZYP_DO_KURC_PO_WEGIE_25G_61778536_0_173_200","Kamis_KAM_PRZYPRAWA_DO_GYROSA_30G_62391727_0_173_200","Kamis_KAMIS_BAZYLIA_10G_61254454_0_173_200","Kamis_KAMIS_Chili_15g_41218157_0_173_200","Kamis_KAMIS_CHINSKA_PRZYPRAWA_5_SMAKOW_20G_27053834_0_173_200","Kamis_KAMIS_CURRY_20G_61318507_0_173_200","Kamis_KAMIS_CYNAMON_MIELONY_15G_63367635_0_173_200","Kamis_KAMIS_CZOSNEK_GRANULOWANY_20G_61302998_0_173_200","Kamis_KAMIS_FAMILY_SUSZONE_POMIDORY_50G_87609194_0_173_200","Kamis_KAMIS_Galka_muszkatolowa_mielona_9g_20253696_0_173_200"]
let polishLanguage = true
// Mark: Detect 3D touch
let is3Dtouch = UIApplication.shared.keyWindow?.traitCollection.forceTouchCapability == UIForceTouchCapability.available
let bundleID = "pl.wroclaw.pwr.Przyprawy3"
var segmentValues : [String] = ["product","producent"]

enum DbTableNames : String {
    case produkty         = "ProductTable"
    case kupione          = "ShopingTable"
    case koszyk           = "BasketProductTable"
    case kupioneProdukty  = "ShopingProductTable"
    case doKupienia       = "ToShopProductTable"
    case uzytkownicy      = "Users"
}
enum SearchField : String {
    case Producent = "producent"
    case Product   = "productName"
    case Tag       = "searchTag"
    case EAN       = "eanCode"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        coreData.saveContext()
    }
///   tu był corebData stack
    // Mark : 3D touch method
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type=="pl.wroclaw.pwr.Przyprawy3.showPictures"{
            print("pl.wroclaw.pwr.Przyprawy3.showPictures")
            let storyBoard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            let initViewController = storyBoard.instantiateViewController(withIdentifier: "3dtouch")
            self.window?.rootViewController=initViewController
            self.window?.makeKeyAndVisible()
        }
    }

}

