//
//  TXPKViewController.swift
//  test-thir
//
//  Created by Jim Chuang on 2018/7/3.
//  Copyright © 2018年 nhr. All rights reserved.
//

import UIKit

class TXPKViewController: UIViewController {

    var pkArr = Array<PKCard>()
    var pOne = Array<PKCard>()
    var pTwo = Array<PKCard>()
    var publicC = Array<PKCard>()

    var peace = [false,false]

    override func viewDidLoad() {
        super.viewDidLoad()
        let getMax = {
            self.pkArr = pkReset()
            NSLog("111")
            let totalCar = combinations(source: self.pkArr, takenBy: 5)
            print(totalCar.count)
            NSLog("222")
            var winCar = totalCar[0]
            for everyCar in totalCar{
                if compare2PkArr(a: everyCar, b: winCar) == 0{
                    winCar = everyCar
                }
            }
            NSLog("333")
            print(pkCardArrToShowStr(oriArr: winCar))
        }
        //getMax()


         //[227294, 1465059, 19951]

        let txCard = {
            var winResult = [0,0,0]
            self.pkArr = pkReset()
            self.pOneGet2Q()
            self.pTwoGet2K()
            NSLog("time 1")
            let totalPubCarArr = combinations(source: self.pkArr, takenBy: 5)
            print("total = ",totalPubCarArr.count)
            NSLog("time 2")

            for publicCard in totalPubCarArr{
                //let aCouple = pOne + publicCard
                //let bCouple = pTwo + publicCard
                let a0 = self.pOne[0]        //aCouple[0]
                let a1 = self.pOne[1]        //aCouple[1]
                let a2 = publicCard[0]   //aCouple[2]
                let a3 = publicCard[1]   //aCouple[3]
                let a4 = publicCard[2]   //aCouple[4]
                let a5 = publicCard[3]   //aCouple[5]
                let a6 = publicCard[4]   //aCouple[6]
                let b0 = self.pTwo[0]         //bCouple[0]
                let b1 = self.pTwo[1]         //bCouple[1]
                let b2 = publicCard[0]   //bCouple[2]
                let b3 = publicCard[1]   //bCouple[3]
                let b4 = publicCard[2]   //bCouple[4]
                let b5 = publicCard[3]   //bCouple[5]
                let b6 = publicCard[4]   //bCouple[6]
                let totalA = [[a0,a1,a2,a3,a4], [a0,a1,a2,a3,a5], [a0,a1,a2,a3,a6], [a0,a1,a2,a4,a5], [a0,a1,a2,a4,a6], [a0,a1,a2,a5,a6], [a0,a1,a3,a4,a5], [a0,a1,a3,a4,a6], [a0,a1,a3,a5,a6], [a0,a1,a4,a5,a6], [a0,a2,a3,a4,a5], [a0,a2,a3,a4,a6], [a0,a2,a3,a5,a6], [a0,a2,a4,a5,a6], [a0,a3,a4,a5,a6], [a1,a2,a3,a4,a5], [a1,a2,a3,a4,a6], [a1,a2,a3,a5,a6], [a1,a2,a4,a5,a6], [a1,a3,a4,a5,a6], [a2,a3,a4,a5,a6]]
                let totalB = [[b0,b1,b2,b3,b4], [b0,b1,b2,b3,b5], [b0,b1,b2,b3,b6], [b0,b1,b2,b4,b5], [b0,b1,b2,b4,b6], [b0,b1,b2,b5,b6], [b0,b1,b3,b4,b5], [b0,b1,b3,b4,b6], [b0,b1,b3,b5,b6], [b0,b1,b4,b5,b6], [b0,b2,b3,b4,b5], [b0,b2,b3,b4,b6], [b0,b2,b3,b5,b6], [b0,b2,b4,b5,b6], [b0,b3,b4,b5,b6], [b1,b2,b3,b4,b5], [b1,b2,b3,b4,b6], [b1,b2,b3,b5,b6], [b1,b2,b4,b5,b6], [b1,b3,b4,b5,b6], [b2,b3,b4,b5,b6]]
                //let totalA = combinations(source: aCouple, takenBy: 5)
                //let totalB = combinations(source: bCouple, takenBy: 5)

                if let x = self.whoWin(totalA: totalA, totalB: totalB){
                    winResult[x] += 1
                    if (winResult[0] + winResult[1] + winResult[2]) % 10000 == 0{
                        NSLog("time 3")//285~300 //500 // 769-833 //1000-1111 //1600-1700 /per second
                    }
                }
            }
            NSLog("time 4")
            print("result = ",winResult)
        }
        txCard()

    }

    func whoWin(totalA:[Array<PKCard>],totalB:[Array<PKCard>]) -> Int?{

        var aCard = totalA[0]
        for x in totalA{
            if compare2PkArr(a: x, b: aCard) == 0{
                aCard = x
            }
        }

        var peace = false
        for x in totalB{
            let result = compare2PkArr(a: x, b: aCard)
            switch result{
            case 0:
                return 1
            case 2:
                peace = true
            default:
                break
            }
        }
        return peace ? 2 : 0
    }

    func whoWin2(totalA:[Array<PKCard>],totalB:[Array<PKCard>]) -> Int?{
        guard totalA.count > 0 else {
            return peace[0] ? 2 : 1
        }
        guard totalB.count > 0 else{
            return peace[1] ? 2 : 0
        }

        let result = compare2PkArr(a: totalA[0], b: totalB[0])
        switch result {
        case 0:
            var b = totalB
            peace[0] = false
            b.removeFirst()
            return whoWin2(totalA:totalA,totalB:b)
        case 1:
            var a = totalA
            peace[1] = false
            a.removeFirst()
            return whoWin2(totalA:a,totalB:totalB)
        default:
            peace[0] = true
            var a = totalA
            a.removeFirst()
            return whoWin2(totalA:a,totalB:totalB)
        }
    }

    func pOneGet2Q(){
        pOne = pkArr.filter{($0.num == 12 && $0.color == 3) || ($0.num == 13 && $0.color == 3)}
        pkArr = pkArr.filter{$0.num != 12 || $0.color != 3}
        pkArr = pkArr.filter{$0.num != 13 || $0.color != 3}
    }

    func pTwoGet2K(){
        pTwo = pkArr.filter{($0.num == 13 && $0.color == 1) || ($0.num == 13 && $0.color == 2)}
        pkArr = pkArr.filter{$0.num != 13 || $0.color != 1}
        pkArr = pkArr.filter{$0.num != 13 || $0.color != 2}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
