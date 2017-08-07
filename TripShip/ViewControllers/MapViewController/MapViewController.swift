//
//  MapViewController.swift
//  TripShip
//
//  Created by user 1 on 31/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate  {

//    var plistPath : String!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myLocationBtn: UIButton!
    @IBOutlet weak var addMarkerBtn: UIButton!
    
    var  askLocation = Bool()
    var isAuthorized = Bool()
    
    // location variables...
    let locationMgr = CLLocationManager()
    var centerLocation = CLLocationCoordinate2D()
    
    //gallery variables
    var picker = UIImagePickerController()
    var imageData = NSData()
    
    var myLocationCoordinate = CLLocationCoordinate2D()
    
    var demoDict = NSMutableDictionary()
    
    func getDataFromPlist(){
        let path = Bundle.main.path(forResource: "Demo", ofType: "plist")
        print(path)
        demoDict = NSMutableDictionary(contentsOfFile: path!)!
        
        if let dict : NSMutableDictionary = demoDict{
            print(dict.value(forKey: "name") ?? "Default name")
            print(dict.value(forKey: "city") ?? "Default name")
            print(dict.value(forKey: "city2") ?? "Default name")
            print(dict.value(forKey: "city3") ?? "Default name")
        }
//        let arr : NSArray = dict!.object(forKey: "PhotoUrl") as! [String] as NSArray
//        print(arr)
        

        
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
//        let documentDirectory = paths[0] as! String
//        let path2 = documentDirectory.appending("MarkerInfo.plist")
//        print(path2)
    }
    
    
    func writeDataToPlist(url : String, key : String){
        let path = Bundle.main.path(forResource: "Demo", ofType: "plist")
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true) as Array
        
        let docPath = directories[0] as String
        let plistPath =  docPath.appending("/Demo.plist")
        
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: plistPath)){
            do{
                try fileManager.copyItem(atPath: path!, toPath: plistPath)
            }
            catch{
                print("copy failure")
            }
        }
        else{
            print("file already exists")
        }
        
        demoDict.setValue(url, forKey: key)
        
//        demoDict.setValue("New York", forKey: "city")
//        demoDict.setValue("New York2", forKey: "city2")
//        demoDict.setValue("New York3", forKey: "city3")
        demoDict.write(toFile: plistPath, atomically: true)
//        demoDict.write(to: plistPath, atomically: true)
        
        
        if let dict : NSMutableDictionary = demoDict{
            print(dict.value(forKey: "name") ?? "Default name")
            print(dict.value(forKey: "city") ?? "Default name")
        }
        
        self.getAgain()
    }
    
    func storeDataIntoPlist(){
        let path = Bundle.main.path(forResource: "MarkerInfo", ofType: "plist")
        print(path)
        var dict = NSMutableDictionary()
        dict.setValue("wow3", forKey: "item")
//        dict.write(toFile: path!, automatica: true)
        
        let str : String = "wow 3 is the best"
        do{
            do{
             try str.write(toFile: path!, atomically: true, encoding: String.Encoding.utf8)
            }
            catch{
             print(Error.self)
            }
        }
//        dict.write(toFile: <#T##String#>, atomically: <#T##Bool#>)
    }
    
    func myFunc(){
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let pathForThePlistFile = delegate.plistPathInDocument
        
        do{
            let str = "wow"
            try str.write(toFile: pathForThePlistFile, atomically: true, encoding: String.Encoding.utf8)
        }
        catch{
            print(error)
        }

    }
    
    func getAgain(){
        let path = Bundle.main.path(forResource: "Demo", ofType: "plist")
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true) as Array
        
        let docPath = directories[0] as String
        let plistPath =  docPath.appending("/Demo.plist")
        
        var dict2 : NSMutableDictionary = NSMutableDictionary(contentsOfFile: plistPath)!
        
        if let dict : NSMutableDictionary = dict2{
            print(dict.value(forKey: "name") ?? "Default name")
            print(dict.value(forKey: "city") ?? "Default name")
            print(dict.value(forKey: "city2") ?? "Default name")
            print(dict.value(forKey: "city3") ?? "Default name")
            
            var lat = self.centerLocation.latitude
            var long  = self.centerLocation.longitude
            
            var key : String = "\(lat)%"+"\(long)"
            print(dict.value(forKey: key))
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        plistPath = delegate.plistPathInDocument
        
//       self.myFunc()
        
        //fetching data from plist
        self.getDataFromPlist()
//        self.writeDataToPlist()
        
        print("now again getting")
//        self.getAgain()
//        print("saving")
//        self.storeDataIntoPlist()
//        print("again getting")
//        self.getDataFromPlist()
        //end
        
        
//        if(askLocation == true){
//            locationMgr.delegate = self
//            self.getLocation()
//            self.mapView.showsUserLocation = true
//            locationMgr.desiredAccuracy = kCLLocationAccuracyBest
//        }
        
        myLocationBtn.layer.cornerRadius = myLocationBtn.bounds.size.width/2
        myLocationBtn.layer.masksToBounds = true
        
        addMarkerBtn.layer.cornerRadius = addMarkerBtn.bounds.size.width/2
        addMarkerBtn.layer.masksToBounds = true
        self.mapView.delegate = self
//        self.getLocation()
//        locationMgr.delegate = self
//        self.getLocation()
//        self.mapView.showsUserLocation = true
//        self.mapView.setCenter(self.mapView.userLocation.coordinate, animated: true)
        
//        Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: #selector(self.goToMyLocationAtStart), userInfo: nil, repeats: false)
        
        
        
        //new code
        if(isAuthorized == true){
            locationMgr.delegate = self
//            self.getLocation()
            self.mapView.showsUserLocation = true
            locationMgr.desiredAccuracy = kCLLocationAccuracyBest
            locationMgr.startUpdatingLocation()
//            self.goToMyLocationAtStart()
            Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: #selector(self.goToMyLocationAtStart), userInfo: nil, repeats: false)

        }
        
//        self.picker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToMyLocationAtStart(){
        if CLLocationManager.locationServicesEnabled(){
            var span = MKCoordinateSpanMake(0.01, 0.01)
            var region = MKCoordinateRegionMake(self.myLocationCoordinate, span)
            
            mapView.setRegion(region, animated: true)
            
            UserDefaults.standard.set(myLocationCoordinate.latitude, forKey: "myLat")
            UserDefaults.standard.set(myLocationCoordinate.longitude, forKey: "myLong")
            UserDefaults.standard.synchronize()
            
//            MKAnnotationView *userLocationAnnotation;
//            userLocationAnnotation = [self.mapView viewForAnnotation:self.mapView.userLocation];
            
//            var userLocAnnot = MKAnnotationView()
//            self.mapView.view(for: self.mapView.userLocation)
        }
        else{
            var span = MKCoordinateSpanMake(0.01, 0.01)
            var region = MKCoordinateRegionMake(self.mapView.userLocation.coordinate, span)
            
            mapView.setRegion(region, animated: true)

        }
    }
    
    func getLocation(){
        let status  = CLLocationManager.authorizationStatus()
        
        // 2
        if status == .notDetermined {
            locationMgr.requestWhenInUseAuthorization()
//            return
        }
        
        // 3
        if status == .denied || status == .restricted {
        }
        
        if CLLocationManager.locationServicesEnabled(){
            //            locationMgr.delegate = self
            locationMgr.startUpdatingLocation()
        }
    }
    
    //Mark : Location service methods
    func checkForLocationServices() {
//        if CLLocationManager.locationServicesEnabled(){
//            // Location services are available, so query the user’s location.
//            print("enabled")
//            locationMgr.delegate = self
//            locationMgr.startUpdatingLocation()
//        } else {
//            print("disabled")
//            let location = CLLocation(latitude: 36.778259, longitude: -119.417931)
//            myLocationCoordinate = location.coordinate
//            // Update your app’s UI to show that the location is unavailable.
//        }
           }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        print("Current location: \(currentLocation)")
        let location = locations.first!
        myLocationCoordinate = location.coordinate
        
        //saving into userdefaults.
        UserDefaults.standard.set(myLocationCoordinate.latitude, forKey: "latitude")
        UserDefaults.standard.set(myLocationCoordinate.longitude, forKey: "longitude")
        UserDefaults.standard.synchronize()
        
        print(myLocationCoordinate)
        
        
//        var coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
//        //span of 0.01 makes the zoom factor of 3
//        coordinateRegion.span.longitudeDelta = 0.01
//        coordinateRegion.span.latitudeDelta = 0.01
//        map.setRegion(coordinateRegion, animated: true)
//        
//        let zoomWidth = map.visibleMapRect.size.width
//        let zoomFactor = Int(log2(zoomWidth)) - 9
//        print("...REGION DID CHANGE: ZOOM FACTOR \(zoomFactor)")
//                locationMgr.stopUpdatingLocation()
    }
    
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
////        let zoomWidth = map.visibleMapRect.size.width
////        let zoomFactor = Int(log2(zoomWidth)) - 9
////        print("...REGION DID CHANGE: ZOOM FACTOR \(zoomFactor)")
//    }
    
//    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        var center = mapView.centerCoordinate
//    }
    // 2
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
//    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        let mapLatitude = mapView.centerCoordinate.latitude
//        let mapLongitude = mapView.centerCoordinate.longitude
//        //center = "Latitude: \(mapLatitude) Longitude: \(mapLongitude)"
//        //print(center)
//    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        var center = mapView.centerCoordinate
        self.centerLocation = mapView.centerCoordinate
        print(center)
    }
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print("hello")
//        var center = mapView.centerCoordinate
//        self.centerLocation = mapView.centerCoordinate
//        print(center)

    }
    @IBAction func addMarkerBtnClicked(_ sender: UIButton) {
        var annotation = MKPointAnnotation()
        var title = "wow"
        var lat = self.centerLocation.latitude
        var long  = self.centerLocation.longitude
        annotation.title = title
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        print("hello")
    }
    
//    func mapview
    // end location manager delegate functions ***************************
    
    
    //Mark : Gallery and picker delegate functions... ********************
    @IBAction func uploadPhoto(_ sender: UIButton) {
//        if CLLocationManager.locationServicesEnabled(){
//            // Location services are available, so query the user’s location.
//            print("enabled")
//            locationMgr.delegate = self
//            locationMgr.startUpdatingLocation()
//        } else {
//            print("disabled")
//            let location = CLLocation(latitude: 36.778259, longitude: -119.417931)
//            myLocationCoordinate = location.coordinate
//            // Update your app’s UI to show that the location is unavailable.
//        }

        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        // Add the actions
        picker.delegate = self
//        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)

    }
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker, animated: true, completion: nil)
        }else{
            self.ShowAlert()
        }
    }
    func openGallary(){
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    //MARK:UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            takeImage.contentMode = .scaleAspectFill
//            takeImage.image = pickedImage
            
            //saving image into the user defaults
            let imgData = UIImageJPEGRepresentation(pickedImage, 0.1)
            UserDefaults.standard.set(imgData, forKey: "profileImage")
            UserDefaults.standard.synchronize()
            
            
            //end
            
            imageData = UIImageJPEGRepresentation(pickedImage, 1.0)! as NSData
            //            imageData = UIImagePNGRepresentation(pickedImage)! as NSData
            var strImage = imageData.base64EncodedString()
            
            var lat = self.centerLocation.latitude
            var long  = self.centerLocation.longitude
            
            var key : String = "\(lat)%"+"\(long)"
            
            self.writeDataToPlist(url: strImage, key: "key")
//            self.strImage = imageData.base64EncodedString()
            
            var imageSize: Int = imageData.length
            print("size of image in KB: %f ", Double(imageSize) / 1024.0)
            //            UserDefaults.standard.set(strImage, forKey: "img")
            self.updateAnnotation()
        }
        self.dismiss(animated: true, completion: nil)
    }
    func updateAnnotation(){
        if let imgData = UserDefaults.standard.object(forKey: "profileImage") as? Data
        {
            if let image = UIImage(data: imgData as Data)
            {
                //set image in UIImageView imgSignature
//                self.takeImage.image = image
                //remove cache after fetching image data
                var annotation = MKPointAnnotation()
                var title = "wow"
                var lat = self.centerLocation.latitude
                var long  = self.centerLocation.longitude
                annotation.title = title
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                self.mapView.addAnnotation(annotation)
//                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                
            }
        }

    }
    func mapView(_ mapView: MKMapView,
                          viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        print("hello")
        if (annotation.isKind(of: MKUserLocation.self)){
            return nil
        }
        

        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.image = UIImage(named:"annotation")
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }
        if let imgData = UserDefaults.standard.object(forKey: "profileImage") as? Data
        {
            if let image = UIImage(data: imgData as Data)
            {
                let pinImage = image
//                annotationView!.image = pinImage
            }
        }
        var shadowImgContainer = UIView()
//        shadowImgContainer.layer.cornerRadius = shadowImgContainer.bounds.size.width/2
//        shadowImgContainer.layer.masksToBounds = true
//        UIView *shadowImgContainer = nil;
//        if (![annotationView viewWithTag:10001]) {
//            shadowImgContainer = [[UIView alloc] init];
            var r : CGRect = shadowImgContainer.frame;
            r.size.width = 40;
            r.size.height = 40;
            shadowImgContainer.frame = r;
//            [shadowImgContainer setTag:10001];
        
            
//            shadowImgView = [[UIImageView alloc] init];
            var shadowImgView = UIImageView()
            r = shadowImgView.frame;
            r.size.width = 40;
            r.size.height = 40;
            shadowImgView.frame = r;
            shadowImgView.contentMode = .scaleToFill
//            [shadowImgView setTag:100001];
            shadowImgContainer.addSubview(shadowImgView)
//            [shadowImgContainer addSubview:shadowImgView];
        shadowImgView.image = UIImage(named: "galleryMarker.png");
        if let imgData = UserDefaults.standard.object(forKey: "profileImage") as? Data
        {
            if let image = UIImage(data: imgData as Data)
            {
                shadowImgView.image = image
            }
        }
        UserDefaults.standard.set(myLocationCoordinate.latitude, forKey: "myLat")
        UserDefaults.standard.set(myLocationCoordinate.longitude, forKey: "myLong")
//        var myLat = Double()
//        var myLong = Double()
//        if let lat : Double = UserDefaults.standard.value(forKey: "myLat") as! Double?{
//            myLat = lat
//        }
//        if let long : Double = UserDefaults.standard.value(forKey: "myLong") as! Double?{
//            myLong = long
//        }
//        
//        if(myLat == myLocationCoordinate.latitude || myLong == myLocationCoordinate.longitude){
//            shadowImgView.image = nil
//        }
//        shadowImgView.image = UIImage(named: "galleryMarker.png");
//        shadowImgContainer.layer.cornerRadius = shadowImgContainer.bounds.size.width/2
        shadowImgContainer.layer.masksToBounds = true
        anView?.frame = r
        anView?.addSubview(shadowImgContainer)
        return anView
    }
        
    func ShowAlert() {
        
        let alert = UIAlertController(title: "Error", message: "Your Device Has No Camera", preferredStyle: UIAlertControllerStyle.alert)
        let cameraAction1 = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
        alert .addAction(cameraAction1)
        self.present(alert, animated: true, completion: nil)
    }

    //end gallery functions
    @IBAction func goToCurrentLocation(_ sender: UIButton) {
        var span = MKCoordinateSpanMake(0.01, 0.01)
        var region = MKCoordinateRegionMake(myLocationCoordinate, span)
        
        self.mapView.setRegion(region, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
