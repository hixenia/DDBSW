//
//  CWStartManuallyViewController.swift
//  DDBSW
//
//  Created by Xenia Rastvorova on 19.03.2018.
//  Copyright © 2018 Kseniia Rastvorova. All rights reserved.
//

import UIKit

class CWInsertManuallyViewController: UIViewController {

    @IBOutlet weak var resultCriterionOne: UILabel!
    @IBOutlet weak var mTextField: UITextField!
    @IBOutlet weak var nTextField: UITextField!
    @IBOutlet weak var P1TextField: UITextField!
    @IBOutlet weak var P2TextField: UITextField!
    @IBOutlet weak var kTextField: UITextField!
    
    
    @IBAction func calculateResult(_ sender: UIButton) {
        var x: [Int] = []//оголошуємо масив змінних х
        var a: [Int] = []
        var m: Int = 0
        if let m1 = mTextField.text{//вводимо значення кількості елементів (машин) множини М
            if let mAsNumber = Int(m1) {
                m = mAsNumber
            }
            print("m=\(m) ")
        }
        x.append(1)
        a.append(1)
        for i in 1..<m {
            x.append(0)
            a.append(0)
        }
        var n: Int = 0//оголошуємо загальну кількість завдань у множинах J1 та J2
        if let n1 = nTextField.text{
            if let nAsNumber = Int(n1) {
                n = nAsNumber
            }
            print("n=\(n) ")
        }
        var P1: Double = 0//оголушуэмо сумму тривалостей виконання завдань на еталонному пристрої для множини завдань J1
        if let p11 = P1TextField.text{
            if let p1AsNumber = Double(p11) {
                P1 = p1AsNumber
            }
            print("P1=\(P1) ")
        }
        var P2: Double = 0//оголушуэмо сумму тривалостей виконання завдань на еталонному пристрої для множини завдань J2
        if let p21 = P2TextField.text{
            if let p2AsNumber = Double(p21) {
                P2 = p2AsNumber
            }
            print("P2=\(P2) ")
        }
        var k: [Double] = []//оголошуємо масив коефіцієнтів продуктивності пристроїв
        if let k1 = kTextField.text{
            if let kAsNumber = Double(k1) {
                k.append(kAsNumber)
            }
            print("k[0]=\(k[0]) ")
        }
       /* k = [0.1, 1.1, 2.1, 3.1, 4.1]
       if let k1 = kTextField.text{
            if let kAsNumber = [Double](k) {
                k = kAsNumber
            }
            print("k=\(k) ")
        }*/
        var mindet: Double = firstCriterion(m: &m, x: &x, k: &k, P1: &P1, P2: &P2)//Обчислимо значення першого критерію та позначимо його як перше мінімальне
        var i: Int = m
        mdivide(i: &i, m: &m, x: &x, k: &k, P1: &P1, P2: &P2, mindet: &mindet, a: &a)//виконаємо повний перебір та пошук масиву із мінімальним значенням першого критерію
        print("\nResult: ")
        for i in 0..<m {//виводимо отриманий масив
            print("\(a[i])")
        }
        print("min fc=\(mindet)")
        resultCriterionOne.text = String(mindet)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //========= Функція, що обчислює значення за формулою першого критерію =======
    func firstCriterion(m: inout Int, x: inout [Int], k: inout [Double], P1: inout Double, P2: inout Double) -> Double {
        var a: Double = 0
        for i in 0..<m {
            a += (P2 + P1) * Double(x[i]) / k[i] - P1/k[i]
            print("a += (\(P2) + \(P1)) * \(Double(x[i])) / \(k[i]) - \(P1/k[i])")
            print(a)
        }
        return abs(a) //  повертаємо модуль значення
    }
    //=== Фунція, що виконує перебір усіх можливих варіантів розбиття множини М ===
    func mdivide(i: inout Int, m: inout Int, x: inout [Int], k: inout [Double], P1: inout Double, P2: inout Double, mindet: inout Double, a: inout [Int]){
        if i>0{
            i-=1
            x[i] = 0
            mdivide(i: &i, m: &m, x: &x, k: &k, P1: &P1, P2: &P2, mindet: &mindet, a: &a)
            x[i] = 1
            mdivide(i: &i, m: &m, x: &x, k: &k, P1: &P1, P2: &P2, mindet: &mindet, a: &a)
        } else {
            var xsum = 0
            for j in 0..<m {
                print(x[j])
                xsum += x[j]
            }
            print("fc=")//fc - First Сriterion - перший критерій
            let det = firstCriterion(m: &m, x: &x, k: &k, P1: &P1, P2: &P2)//обраховуэмо значення за формулою першого критерію
            print(det)
            if (det < mindet) && (xsum != 0) && (xsum != m){//якщо отримане значення за формулою менше
                mindet = det //за мінімальне та множини М1 та М2 при даному розбитті не пусті
                //збережемо нове мінімальне значення
                for j in 0..<m {
                    a[j] = x[j]//збережемо нове мінімальне значення
                }
            }
        }
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
