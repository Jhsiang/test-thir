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
        pOne = quickSorting(oriArray: pOne)

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

    }



//MARK: - Button Click
    @IBAction func dealClick(_ sender: UIButton) {
        (pOne,pTwo,pThree,pFour) = deal(pk: pkArray)
        pOne = quickSorting(oriArray: pOne)
        
        p1CollectionView.reloadData()
    }

    @IBAction func washClick(_ sender: UIButton) {
        pkArray = wash(pkA: pkArray)
    }

    @IBAction func resultClick(_ sender: UIButton) {
        print("result = \(pOneSet)")
        print("resut = \(numberToString(oriArray: pOneSet[0])) \(numberToString(oriArray: pOneSet[1])) \(numberToString(oriArray: pOneSet[2]))")
    }

    @IBAction func sendClick(_ sender: UIButton) {
        if pOne.count != 5 && pOne.count != 10 && pOne.count != 13{
            print("test = \(pOne.count)")
        }else{
            var selectCount = 0
            var arr = Array<Int>()
            for x in 0...pOne.count-1{
                if self.p1CollectionView.cellForItem(at: IndexPath(row: x, section: 0))?.backgroundColor == UIColor.yellow{
                    selectCount += 1
                    arr.append(pOne[x])
                }
            }
            //print("sel count = \(selectCount)")
            if (selectCount == 3 && pOne.count == 13) || selectCount == 5{
                for x in 0...arr.count-1{
                    pOne = deleteArrEle(array: pOne, element: arr[x])
                }
                pOneSet.append(arr)
            }else{
                print("select error")
            }
            self.p1CollectionView.reloadData()
        }
    }

    func deleteArrEle(array:Array<Int>,element: Int) -> Array<Int> {
        return array.filter() { $0 != element }
    }

    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! P1CollectionViewCell
        cell.cardLabel.text = pOne.count > indexPath.item ? numberToString2(number: pOne[indexPath.item]) : "None"
        cell.cardLabel.sizeToFit()
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.black.cgColor
        self.p1CollectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.clear
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.p1CollectionView.cellForItem(at: indexPath)?.backgroundColor = self.p1CollectionView.cellForItem(at: indexPath)?.backgroundColor == UIColor.yellow ?
        UIColor.clear : UIColor.yellow
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

