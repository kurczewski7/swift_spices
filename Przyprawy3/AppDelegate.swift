//
//  AppDelegate.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 20.07.2018.
//  Copyright © 2018 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData

let picturesArray: [String] =
    ["CYKORIA_ARROD_PAPRYKA_OSTRA_MIELONA_10G_59954826_0_173_200","CYKORIA_ARROD_PIEPRZ_CZARNY_ZIARNISTY_11G_60057064_0_173_200",
     "CYKORIA_ARROD_PRZYPRAWA_DO_KURCZAKA_20G_60194487_0_173_200","CYKORIA_BAZYLIA_CYKORIA_10_g_60066362_0_173_200",
     "CYKORIA_CHILI_20G_CYKORIA_60002862_0_173_200","CYKORIA_CURRY_25G_CYKORIA_60114196_0_173_200",
     "CYKORIA_CYNAMON_MIELONY_20G_CYKORIA_63402101_0_173_200","CYKORIA_CZOSNEK_SUSZONY_GRANULOWANY_20G_CYKORIA_60103033_0_173_200",
     "CYKORIA_ESTRAGON_10G_CYKORIA_60920808_0_173_200","CYKORIA_GALKA_MUSZKATOLOWA_MIELONA_15G_61107553_0_173_200",
     "CYKORIA_GORCZYCA_CYKORIA_25_g_60223088_0_173_200","CYKORIA_IMBIR_MIELONY_20G_CYKORIA_60955721_0_173_200",
     "CYKORIA_Jalowiec_15g_53445060_0_173_200","CYKORIA_KMINEK_20G_CYKORIA_59584029_0_173_200",
     "CYKORIA_KOLENDRA_MIELONA_20G_CYKORIA_60947785_0_173_200","Dr_Oetker_Dr_Oetker_Przyprawa_korzenna_40g_76415553_0_173_200",   "Kamis_Aromatyczny_Pstrag_Z_Koperkiem_18g_35965474_0_173_200","Kamis_FAMILY_MAJERANEK_18G_87417754_0_173_200","Kamis_FAMILY_PAPRYKA_SLODKA_50G_87681805_0_173_200","Kamis_FAMILY_PIEPRZ_ZIOLOWY_50G_87295275_0_173_200","Kamis_FAMILY_PRZYPRAWA_DO_GYROSA_70G_87450078_0_173_200","Kamis_FAMILY_PRZYPRAWA_DO_KURCZAKA_75G_87502506_0_173_200","Kamis_FAMILY_ZIOLA_PROWANSALSKIE_25G_87347761_0_173_200","Kamis_GRILL_CHRUPIACE_WARZYWA_39225271_0_173_200","Kamis_GRILL_KASZANKA_Z_CEBULKA_39501788_0_173_200","Kamis_Grill_Srodziemnomorski_20g_37625365_0_173_200","Kamis_GRILL_ZIEMNIAKI_PIECZONE_39513239_0_173_200","Kamis_KAM_KOPEREK_6G_62938774_0_173_200","Kamis_KAM_OREGANO_10G_61704995_0_173_200","Kamis_KAM_PRZYP_DO_DAN_MEKSYK_25G_62277777_0_173_200","Kamis_KAM_PRZYP_DO_KURC_PO_WEGIE_25G_61778536_0_173_200","Kamis_KAM_PRZYPRAWA_DO_GYROSA_30G_62391727_0_173_200","Kamis_KAMIS_BAZYLIA_10G_61254454_0_173_200","Kamis_KAMIS_Chili_15g_41218157_0_173_200","Kamis_KAMIS_CHINSKA_PRZYPRAWA_5_SMAKOW_20G_27053834_0_173_200","Kamis_KAMIS_CURRY_20G_61318507_0_173_200","Kamis_KAMIS_CYNAMON_MIELONY_15G_63367635_0_173_200","Kamis_KAMIS_CZOSNEK_GRANULOWANY_20G_61302998_0_173_200","Kamis_KAMIS_FAMILY_SUSZONE_POMIDORY_50G_87609194_0_173_200","Kamis_KAMIS_Galka_muszkatolowa_mielona_9g_20253696_0_173_200"]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
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
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Przyprawy3")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

