//
//  ViewController.swift
//  DDBSW
//
//  Created by Xenia Rastvorova on 18.03.2018.
//  Copyright © 2018 Kseniia Rastvorova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var x: [Int] = [1, 0, 0, 0, 0]//оголошуємо масив змінних х
        var a: [Int] = [1, 0, 0, 0, 0]
        var m: Int = 5 //вводимо значення кількості елементів (машин) множини М
        var n: Int = 8 //оголошуємо загальну кількість завдань у множинах J1 та J2
        var P1: Double = 10 //оголушуэмо сумму тривалостей виконання завдань на еталонному пристрої для множини завдань J1
        var P2: Double = 7 // Та J2
        var k: [Double] = [0.1, 1.1, 2.1, 3.1, 4.1]//оголошуємо масив коефіцієнтів продуктивності пристроїв
        var mindet: Double = firstCriterion(m: &m, x: &x, k: &k, P1: &P1, P2: &P2)//Обчислимо значення першого критерію та позначимо його як перше мінімальне
        var i: Int = m
        mdivide(i: &i, m: &m, x: &x, k: &k, P1: &P1, P2: &P2, mindet: &mindet, a: &a)//виконаємо повний перебір та пошук масиву із мінімальним значенням першого критерію
        print("\nResult: ")
        for i in 0..<m {//виводимо отриманий масив
            print("\(a[i])")
        }
        print("min fc=\(mindet)")
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
}

