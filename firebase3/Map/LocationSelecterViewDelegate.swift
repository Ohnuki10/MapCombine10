//
//  LocationSelecterViewDelegate.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/31.
//

import SwiftUI
import MapKit


public protocol LocationSelecterViewDelegate: AnyObject {
    func locationDidSet(location: CLLocationCoordinate2D)
}

public class UILocationSelecterView: UIView {
    public var locationLimit: Int?
    private lazy var mapView = MKMapView()
    weak public var delegate: LocationSelecterViewDelegate?

    private let verticalLine = CAShapeLayer()
    private let horizontalLine = CAShapeLayer()
    

    
    
    

    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        mapView.delegate = self
        addSubview(mapView)
        

        verticalLine.fillColor = nil
        verticalLine.opacity = 1.0
        verticalLine.strokeColor = UIColor.black.cgColor
        layer.addSublayer(verticalLine)

        horizontalLine.fillColor = nil
        horizontalLine.opacity = 1.0
        horizontalLine.strokeColor = UIColor.black.cgColor
        layer.addSublayer(horizontalLine)
    }

    public override func layoutSubviews() {

        mapView.frame =  CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)

        let verticalLinePath = UIBezierPath()
        verticalLinePath.move(to: CGPoint(x: (bounds.width / 2) - 10, y: bounds.height / 2))
        verticalLinePath.addLine(to: CGPoint(x: (bounds.width / 2) + 10, y: bounds.height / 2))
        verticalLine.path = verticalLinePath.cgPath

        let horizontalLinePath = UIBezierPath()
        horizontalLinePath.move(to: CGPoint(x: bounds.width / 2, y: (bounds.height / 2) - 10))
        horizontalLinePath.addLine(to: CGPoint(x: bounds.width / 2, y: (bounds.height / 2) + 10))
        horizontalLine.path = horizontalLinePath.cgPath


    }
    
    // Remove All Annotation　　追加
    func removeAllAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    
    
    
    
    
//     Anotation　　ピン自体
    func addAnotationRed(location: CLLocationCoordinate2D, title: String) {
        let annotationRed = TestMKPointAnnotation()
        annotationRed.coordinate = location
        annotationRed.title = title
        annotationRed.pinColor = UIColor.red
        mapView.addAnnotation(annotationRed)
    }


    func addAnotationWhite(location: CLLocationCoordinate2D, title: String) {
        let annotationWhite = TestMKPointAnnotation()
        annotationWhite.coordinate = location
        annotationWhite.title = title
        annotationWhite.pinColor = UIColor.white
        mapView.addAnnotation(annotationWhite)
    }

    func addAnotationBlue(location: CLLocationCoordinate2D, title: String) {
        let annotationBlue = TestMKPointAnnotation()
        annotationBlue.coordinate = location
        annotationBlue.title = title
        annotationBlue.pinColor = UIColor.blue
        mapView.addAnnotation(annotationBlue)
    }



    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let testPinView = MKPinAnnotationView()
                
                //アノテーションビューに座標、タイトル、サブタイトルを設定する。
                testPinView.annotation = annotation

                //アノテーションビューに色を設定する。
                if let test = annotation as? TestMKPointAnnotation {
                    testPinView.pinTintColor = test.pinColor
                }
        
        
        return testPinView
    }
    

    
}

extension UILocationSelecterView: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    
        let location = CLLocationCoordinate2D(latitude: mapView.region.center.latitude, longitude: mapView.region.center.longitude)
        mapView.showsUserLocation=true
        
        
       
        delegate?.locationDidSet(location: location)
        
       
    }
}

