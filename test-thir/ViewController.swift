//
//  ViewController.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/2/22.
//  Copyright © 2018年 nhr. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var pkArray = Array<Int>()
    var pOne = Array<Int>()
    var pTwo = Array<Int>()
    var pThree = Array<Int>()
    var pFour = Array<Int>()

    var pOneSet = Array<Array<Int>>()
    var pTwoSet = Array<Array<Int>>()
    var pThreeSet = Array<Array<Int>>()
    var pFourSet = Array<Array<Int>>()

    var allSet = Array<Any>()

    @IBOutlet var p1CollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        var bb = [0,0,0,0]

        for index in 0...0{

        pkArray = wash(pkA: pkArray)
        //print("pk = \(pkArray)")

        (pOne,pTwo,pThree,pFour) = deal(pk: pkArray)
        //pOne = quickSorting(oriArray: pOne)
        //pOne = [4, 6, 10, 14, 15, 23, 24, 30, 35, 38, 46, 49, 51]
        //print("pOne = \(pOne)")

        pOneSet = autoArrangement(oriArray: pOne)
        pTwoSet = autoArrangement(oriArray: pTwo)
        pThreeSet = autoArrangement(oriArray: pThree)
        pFourSet = autoArrangement(oriArray: pFour)

//        print("\(numberToString(oriArray: pOneSet[0]))\(numberToString(oriArray: pOneSet[1]))\(numberToString(oriArray: pOneSet[2]))")
//        print("\(numberToString(oriArray: pTwoSet[0]))\(numberToString(oriArray: pTwoSet[1]))\(numberToString(oriArray: pTwoSet[2]))")
//        print("\(numberToString(oriArray: pThreeSet[0]))\(numberToString(oriArray: pThreeSet[1]))\(numberToString(oriArray: pThreeSet[2]))")
//        print("\(numberToString(oriArray: pFourSet[0]))\(numberToString(oriArray: pFourSet[1]))\(numberToString(oriArray: pFourSet[2]))")

        allSet.append(pOneSet)
        allSet.append(pTwoSet)
        allSet.append(pThreeSet)
        allSet.append(pFourSet)

        //print("\(calResult(oriArray: allSet))")


        let aa = calResult(oriArray: allSet)
            //print(aa)
            for x in 0...3{
                bb[x] += aa[x]

            }
            //NSLog("\(bb)")
                    allSet.removeAll()

            }
        NSLog("\(bb)")
        //if
        //var testc = (5,30,3,4,5)
        //var testd = [0,9,10,11,12]

        //print("first = \(compare(oriArray: testA)) second = \(compare(oriArray: testB)) third = \(compare(oriArray: testC)) forth = \(compare(oriArray: testd))")
        //print("forth = \(numberToString(oriArray: testd))")
        //print("forth = \(compare(oriArray: testd))")
    }



//MARK: - Button Click
    @IBAction func dealClick(_ sender: UIButton) {
        (pOne,pTwo,pThree,pFour) = deal(pk: pkArray)

        p1CollectionView.reloadData()
    }

    @IBAction func washClick(_ sender: UIButton) {
        pkArray = wash(pkA: pkArray)
    }

    @IBAction func resultClick(_ sender: UIButton) {

    }

    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! P1CollectionViewCell
        cell.cardLabel.text = pOne.count != 0 ? numberToString2(number: pOne[indexPath.item]) : "??"
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGSize = CGSize(width: collectionView.frame.width/13, height: collectionView.frame.height)
        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

