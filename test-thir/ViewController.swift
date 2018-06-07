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


    @IBOutlet var firView: UIView!
    @IBOutlet var secView: UIView!
    @IBOutlet var thiView: UIView!
    @IBOutlet var fouView: UIView!
    @IBOutlet var p1CollectionView: UICollectionView!


    @IBOutlet var pOneLabel: UILabel!
    @IBOutlet var pTwoLabel: UILabel!
    @IBOutlet var pThreeLabel: UILabel!
    @IBOutlet var pFourLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        // 大量統計結果
        var autoRunResult = [0,0,0,0]

        // auto run 統計結果
        for _ in 0...0{

            // 打亂總陣列
            pkArray = wash(pkA: pkArray)

            // 重新分配
            (pOne,pTwo,pThree,pFour) = deal(pk: pkArray)
            pOne = quickSorting(oriArray: pOne)

            // AI 自動排列
            //pOneSet = autoArrangement(oriArray: pOne)
            pTwoSet = autoArrangement(oriArray: pTwo)
            pThreeSet = autoArrangement(oriArray: pThree)
            pFourSet = autoArrangement(oriArray: pFour)

            // Label顯示
            pOneLabel.adjustsFontSizeToFitWidth = true
            pTwoLabel.adjustsFontSizeToFitWidth = true
            pThreeLabel.adjustsFontSizeToFitWidth = true
            pFourLabel.adjustsFontSizeToFitWidth = true
            resultLabel.adjustsFontSizeToFitWidth = true

            pOneLabel.text = ""
            pTwoLabel.text = ""
            pTwoLabel.text = ""
            pThreeLabel.text = ""
            pFourLabel.text = ""
            resultLabel.text = ""

            /*
             print("\(numberToString(oriArray: pOneSet[0]))\(numberToString(oriArray: pOneSet[1]))\(numberToString(oriArray: pOneSet[2]))")
             print("\(numberToString(oriArray: pTwoSet[0]))\(numberToString(oriArray: pTwoSet[1]))\(numberToString(oriArray: pTwoSet[2]))")
             print("\(numberToString(oriArray: pThreeSet[0]))\(numberToString(oriArray: pThreeSet[1]))\(numberToString(oriArray: pThreeSet[2]))")
             print("\(numberToString(oriArray: pFourSet[0]))\(numberToString(oriArray: pFourSet[1]))\(numberToString(oriArray: pFourSet[2]))")

             allSet.append(pOneSet)
             allSet.append(pTwoSet)
             allSet.append(pThreeSet)
             allSet.append(pFourSet)

             print("\(calResult(oriArray: allSet))")
             */

            /*
            let singleResult = calResult(oriArray: allSet)
            //print(aa)
            for x in 0...3{
                autoRunResult[x] += singleResult[x]
            }
            allSet.removeAll()
             */
        }
        //NSLog("\(autoRunResult)")
    }

//MARK: - Button Click
    @IBAction func dealClick(_ sender: UIButton) {

        // 重新分配
        (pOne,pTwo,pThree,pFour) = deal(pk: pkArray)
        // 排列
        pOne = quickSorting(oriArray: pOne)
        // 清空比較陣列
        pOneSet.removeAll()

        // 顯示清空
        pOneLabel.text = ""
        pTwoLabel.text = ""
        pTwoLabel.text = ""
        pThreeLabel.text = ""
        pFourLabel.text = ""
        resultLabel.text = ""

        // UI自動排版
        pTwoSet = autoArrangement(oriArray: pTwo)
        pThreeSet = autoArrangement(oriArray: pThree)
        pFourSet = autoArrangement(oriArray: pFour)

        // CollectionView重載
        p1CollectionView.reloadData()
    }

    @IBAction func washClick(_ sender: UIButton) {
        pkArray = wash(pkA: pkArray)

        // 顯示清空
        pOneLabel.text = ""
        pTwoLabel.text = ""
        pTwoLabel.text = ""
        pThreeLabel.text = ""
        pFourLabel.text = ""
        resultLabel.text = ""

        // 清空比較陣列
        pOneSet.removeAll()
        allSet.removeAll()
    }

    func setToLabel(arr:Array<Array<Int>>) -> String{

        let first = numberToString(oriArray: arr[0])
        let second = numberToString(oriArray: arr[1])
        let third = numberToString(oriArray: arr[2])
        var resultStr = ""
        for x in 0...first.count-1{
            resultStr += first[x]
        }
        resultStr += "          "
        for x in 0...second.count-1{
            resultStr += second[x]
        }
        resultStr += "          "
        for x in 0...third.count-1{
            resultStr += third[x]
        }
        return resultStr
    }

    func setToLabel2(arr:Array<Array<Int>>) -> String{

        let first = numberToString(oriArray: arr[0])
        let second = numberToString(oriArray: arr[1])
        let third = numberToString(oriArray: arr[2])
        var resultStr = ""
        for x in 0...first.count-1{
            resultStr += first[x] + "\n"
        }
        resultStr += "\n\n"
        for x in 0...second.count-1{
            resultStr += second[x] + "\n"
        }
        resultStr += "\n\n"
        for x in 0...third.count-1{
            resultStr += third[x] + "\n"
        }
        return resultStr
    }

    @IBAction func resultClick(_ sender: UIButton) {

        print("result = \(pOneSet)")
        guard pOneSet.count == 3 else { return}

        // 顯示字串化結果
        print("\(numberToString(oriArray: pOneSet[0]))\(numberToString(oriArray: pOneSet[1]))\(numberToString(oriArray: pOneSet[2]))")
        print("\(numberToString(oriArray: pTwoSet[0]))\(numberToString(oriArray: pTwoSet[1]))\(numberToString(oriArray: pTwoSet[2]))")
        print("\(numberToString(oriArray: pThreeSet[0]))\(numberToString(oriArray: pThreeSet[1]))\(numberToString(oriArray: pThreeSet[2]))")
        print("\(numberToString(oriArray: pFourSet[0]))\(numberToString(oriArray: pFourSet[1]))\(numberToString(oriArray: pFourSet[2]))")

        pOneLabel.text = setToLabel(arr: pOneSet)
        pTwoLabel.text = setToLabel2(arr: pTwoSet)
        pThreeLabel.text = setToLabel(arr: pThreeSet)
        pFourLabel.text = setToLabel2(arr: pFourSet)

        //pTwoLabel += numberToString(oriArray: pOneSet[0])

        // 載入比較陣列
        allSet.append(pOneSet)
        allSet.append(pTwoSet)
        allSet.append(pThreeSet)
        allSet.append(pFourSet)

        // 顯示比較結果
        let resultArr = calResult(oriArray: allSet)
        print("\(resultArr)")
        resultLabel.text = "P1:  \(resultArr[0])注    P2:  \(resultArr[1])注\nP3:  \(resultArr[2])注    P4:  \(resultArr[3])注"

        // 清除比較陣列
        pOneSet.removeAll()
        allSet.removeAll()
    }

    @IBAction func sendClick(_ sender: UIButton) {

        // 滿足三五五順序
        if pOne.count != 5 && pOne.count != 10 && pOne.count != 13{
            print("test = \(pOne.count)")
        }else{
            var selectCount = 0
            var arr = Array<Int>()
            for x in 0...pOne.count-1{

                // 從顏色判斷選擇
                if self.p1CollectionView.cellForItem(at: IndexPath(row: x, section: 0))?.backgroundColor == UIColor.yellow{
                    selectCount += 1
                    arr.append(pOne[x])
                }
            }

            // 滿足選擇數量，重組陣列並載入新陣列
            if (selectCount == 3 && pOne.count == 13) || selectCount == 5{
                for x in 0...arr.count-1{
                    // 刪除指定元素
                    pOne = deleteArrEle(array: pOne, element: arr[x])
                }
                // 載入比較陣列
                pOneSet.append(arr)
            }else{
                print("select error selectCount = \(selectCount)")
            }
            self.p1CollectionView.reloadData()
        }
    }

//MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pOne.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! P1CollectionViewCell
        cell.cardLabel.text = pOne.count > indexPath.item ? numberToString2(number: pOne[indexPath.item]) : "None"
        cell.cardLabel.sizeToFit()
        cell.cardLabel.adjustsFontSizeToFitWidth = true
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.black.cgColor

        // 重載時清空選擇
        cell.backgroundColor = UIColor.clear
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 選擇提示
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

