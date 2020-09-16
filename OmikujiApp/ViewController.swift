//
//  ViewController.swift
//  OmikujiApp
//
//  Created by 渋谷柚花 on 2020/09/14.
//  Copyright © 2020 渋谷柚花. All rights reserved.
//

import UIKit
//各機能のライブラリ（特定の機能や用途をまとめたもの）をプログラム内で使えるようになる
import AVFoundation


class ViewController: UIViewController {
    
    
    var resultAudioPlayer: AVAudioPlayer = AVAudioPlayer()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupSound()
    }

    
    @IBOutlet var stickView: UIImageView!
    
    @IBOutlet var stickLabel: UILabel!

    @IBOutlet var stickHeight: NSLayoutConstraint!
    
    @IBOutlet var stickBottomMargin: NSLayoutConstraint!
    
    
    @IBOutlet var overView: UIView!
    
    
    @IBOutlet var bigLabel: UILabel!
    
    
    
    let resultTexts: [String] = [
       "大吉",
        "中吉",
        "小吉",
        "吉",
        "末吉",
        "凶",
        "大凶",
    ]
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion != UIEvent.EventSubtype.motionShake || overView.isHidden == false{
            // シェイクモーション以外では動作させない
            // 結果の表示中は動作させない
            return
            
        }
        
        
        
        
        
//       arc4random_uniform関数は、0〜引数にとった値-1 の範囲の整数をランダムに返す関数です
        let resultNum = Int(arc4random_uniform(UInt32(resultTexts.count))
        )
        
        stickLabel.text = resultTexts[resultNum]
    
        stickBottomMargin.constant = stickHeight.constant * -1
//        UIView.animate関数 = アニメーション
//        withDuration　= アニメーションの秒数
//        制約の変更でアニメーションさせる
        UIView.animate(withDuration: 1.0, animations:{
            self.view.layoutIfNeeded()
        },completion: { (finished:Bool) in
//            bigLabelにstickLabelのテキストをコピー
            self.bigLabel.text = self.stickLabel.text
//            overViewのHiddenを解除
            self.overView.isHidden = false
            self.resultAudioPlayer.play()
        })
    }
    
    @IBAction func tapRetryButton(_ sender: Any) {
//        overViewを再び非表示
    overView.isHidden = true
//     シェイク時に変更された制約の値を0に戻して、再度おみくじ棒が本体の中に隠れるようにする
    stickBottomMargin.constant = 0
    }
    
    func setupSound() {
        
        if let sound = Bundle.main.path(forResource: "drum", ofType: ".mp3"){
            resultAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            resultAudioPlayer.prepareToPlay()
            }
    }
    
    

    
    
    
}
