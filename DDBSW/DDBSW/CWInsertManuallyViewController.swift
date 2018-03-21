//
//  CWStartManuallyViewController.swift
//  DDBSW
//
//  Created by Xenia Rastvorova on 19.03.2018.
//  Copyright © 2018 Kseniia Rastvorova. All rights reserved.
//

import UIKit

class CWInsertManuallyViewController: UIViewController {

    @IBOutlet weak var mTextField: UITextField!
    @IBOutlet weak var nTextField: UITextField!
    @IBOutlet weak var P1TextField: UITextField!
    @IBOutlet weak var P2TextField: UITextField!
    @IBOutlet weak var d1TextField: UITextField!
    @IBOutlet weak var d2TextField: UITextField!
    @IBOutlet weak var kTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var criterionLabel: UILabel!
    @IBOutlet weak var divideLabel: UILabel!
    
    
    @IBAction func calculateResult(_ sender: UIButton) {
        var x: [Int] = []//оголошуємо масив змінних х
        var a1: [Int] = []
        var a2: [Int] = []
        var a3: [Int] = []
        var m: Int = 0
        if let m1 = mTextField.text{//вводимо значення кількості елементів (машин) множини М
            if let mAsNumber = Int(m1) {
                m = mAsNumber
            }
            print("m=\(m) ")
        }
        x.append(1)
        a1.append(1)
        a2.append(1)
        a3.append(1)
        for i in 1..<m {
            x.append(0)
            a1.append(0)
            a2.append(0)
            a3.append(0)
        }
        var n: Int = 0//оголошуємо загальну кількість завдань у множинах J1 та J2
        if let n1 = nTextField.text{
            if let nAsNumber = Int(n1) {
                n = nAsNumber
            }
            print("n=\(n) ")
        }
        var P1: Double = 0//оголушуємо сумму тривалостей виконання завдань на еталонному пристрої для множини завдань J1
        if let p11 = P1TextField.text{
            if let p1AsNumber = Double(p11) {
                P1 = p1AsNumber
            }
            print("P1=\(P1) ")
        }
        var P2: Double = 0//оголушуємо сумму тривалостей виконання завдань на еталонному пристрої для множини завдань J2
        if let p21 = P2TextField.text{
            if let p2AsNumber = Double(p21) {
                P2 = p2AsNumber
            }
            print("P2=\(P2) ")
        }
        var d1: Double = 0//оголошуємо d1
        if let d11 = d1TextField.text{
            if let d1AsNumber = Double(d11) {
                d1 = d1AsNumber
            }
            print("d1=\(d1) ")
        }
        
        var d2: Double = 0//оголошуємо d2
        if let d21 = d1TextField.text{
            if let d2AsNumber = Double(d21) {
                d2 = d2AsNumber
            }
            print("d2=\(d2) ")
        }
        
        var k: [Double] = []//оголошуємо масив коефіцієнтів продуктивності пристроїв
    //    var s: [String] = []

        if let k1 = kTextField.text{
                var s = k1.components(separatedBy: [" "])
                print("s=\(s) ")
            for i in 0..<s.count {
                k.append(NSString(string: s[i]).doubleValue)
            }
            print("k[0]=\(k[0]) ")
        }
        var mincr1: Double = firstCriterion(m: &m, x: &x, k: &k, P1: &P1, P2: &P2)//Обчислимо значення першого критерію та позначимо його як перше мінімальне
        var mincr2: Double = secondCriterion(m: &m, x: &x, k: &k, d1: &d1, d2: &d2)
        var mincr3: Double = thirdCriterion(m: &m, x: &x, k: &k, P1: &P1, P2: &P2, d1: &d1, d2: &d2)
        mdivide(i: 0, m: &m, x: &x, k: &k, P1: &P1, P2: &P2,  d1: &d1, d2: &d2, mincr1: &mincr1, mincr2: &mincr2, mincr3: &mincr3, a1: &a1, a2: &a2, a3: &a3)//виконаємо повний перебір та пошук масиву із мінімальним значенням першого критерію
        print("\nResult: ")
            print("\(x)")
        print("\(a1)")
        print("\(a2)")
        print("\(a3)")

        print("min fc=\(mincr1)")
        view.endEditing(true)
        let s1 = String(round(mincr1*1000)/1000)
        let s2 = String(round(mincr2*1000)/1000)
        let s3 = String(round(mincr3*1000)/1000)
        numberLabel.text = " №\n 1.\n 2.\n 3."
        criterionLabel.text = "Значення\n" + s1 + "\n" + s2 + "\n" + s3
        if (m<11) {
        divideLabel.text = "Розбиття\n" + String(describing: a1) + "\n" + String(describing: a2) + "\n" + String(describing: a3)
        }
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
            /*print("a += (\(P2) + \(P1)) * \(Double(x[i])) / \(k[i]) - \(P1/k[i])")
            print(a)*/
        }
        return abs(a) //  повертаємо модуль значення
    }
    //========= Функція, що обчислює значення за формулою другого критерію =======
    func secondCriterion(m: inout Int, x: inout [Int], k: inout [Double], d1: inout Double, d2: inout Double) -> Double {
        var a: Double = 0
        for i in 0..<m {
            a += (d1 + d2) * Double(x[i]) / k[i] - d2/k[i]
           /* print("a += (\(d1) + \(d2)) * \(Double(x[i])) / \(k[i]) - \(d2/k[i])")
            print(a)*/
        }
        return abs(a) //  повертаємо модуль значення
    }
    //========= Функція, що обчислює значення за формулою третього критерію =======
    func thirdCriterion(m: inout Int, x: inout [Int], k: inout [Double], P1: inout Double, P2: inout Double, d1: inout Double, d2: inout Double) -> Double {
        var a: Double = 0
        for i in 0..<m {
            a += (P2 * d1 + P1 * d2) * Double(x[i]) / k[i] - P1 * d2/k[i]
           /* print("a += (\(P2) * \(d1) + \(P1) * \(d2)) * \(Double(x[i])) / \(k[i]) - \(P1*d2/k[i])")
            print(a)*/
        }
        return abs(a) //  повертаємо модуль значення
    }
    
    //=== Функція, що виконує перебір усіх можливих варіантів розбиття множини М ===
    func mdivide(i: Int, m: inout Int, x: inout [Int], k: inout [Double], P1: inout Double, P2: inout Double, d1: inout Double, d2: inout Double, mincr1: inout Double, mincr2: inout Double, mincr3: inout Double, a1: inout [Int], a2: inout [Int], a3: inout [Int]){
        print(i)
        if i<m{
            x[i] = 0
            mdivide(i: i+1, m: &m, x: &x, k: &k, P1: &P1, P2: &P2, d1: &d1, d2: &d2, mincr1: &mincr1, mincr2: &mincr2, mincr3: &mincr3, a1: &a1, a2: &a2, a3: &a3)
            x[i] = 1
            mdivide(i: i+1, m: &m, x: &x, k: &k, P1: &P1, P2: &P2, d1: &d1, d2: &d2, mincr1: &mincr1, mincr2: &mincr2, mincr3: &mincr3, a1: &a1, a2: &a2, a3: &a3)
        } else {
            var xsum = 0
            for j in 0..<m {
                xsum += x[j]
            }
            print(x)///dssd
            var det = firstCriterion(m: &m, x: &x, k: &k, P1: &P1, P2: &P2)//обраховуэмо значення за формулою першого критерію
            if (det < mincr1) && (xsum != 0) && (xsum != m){//якщо отримане значення за формулою менше
                mincr1 = det //за мінімальне та множини М1 та М2 при даному розбитті не пусті
                //збережемо нове мінімальне значення
                for j in 0..<m {
                    a1[j] = x[j]//збережемо нове мінімальне значення
                }
            }
            det = secondCriterion(m: &m, x: &x, k: &k, d1: &d1, d2: &d2)//обраховуэмо значення за формулою першого критерію
            if (det < mincr2) && (xsum != 0) && (xsum != m){//якщо отримане значення за формулою менше
                mincr2 = det //за мінімальне та множини М1 та М2 при даному розбитті не пусті
                //збережемо нове мінімальне значення
                for j in 0..<m {
                    a2[j] = x[j]//збережемо нове мінімальне значення
                }
            }
            det = thirdCriterion(m: &m, x: &x, k: &k, P1: &P1, P2: &P2, d1: &d1, d2: &d2)//обраховуэмо значення за формулою першого критерію
            if (det < mincr3) && (xsum != 0) && (xsum != m){//якщо отримане значення за формулою менше
                mincr3 = det //за мінімальне та множини М1 та М2 при даному розбитті не пусті
                //збережемо нове мінімальне значення
                for j in 0..<m {
                    a3[j] = x[j]//збережемо нове мінімальне значення
                }
            }
        }
    }
}
