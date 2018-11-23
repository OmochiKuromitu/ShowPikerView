//
//  ViewController.swift
//  testCode
//
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 今回はボタンのイベントではなく、テキストフィールドを使うのがポイント
    // テキストフィールドをUIViewControllerにのせると、特別な実装をしなくてもタップするとキーボードがでてくる
    // 今回はキーボードではなく、pikeviewを表示するようにしている
    @IBOutlet weak var textField: UITextField!
    
    // pickerViewクラス変数か、プロパティで持っておく
    let pickerView = UIPickerView()
    // ↓のarrayには表示したいカテゴリを入れてください。とりあえず固定値でいれてます
    var array = ["楽天", "ソニー", "APPLE", "amazon", "softbank"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // pikerviewの初期設定。横はスクリーンサイズ、高さはpikerviewクラスがデフォルトで持っている大きさ。200,100とかいれて好きなサイズにしてもいい
        pickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: pickerView.bounds.size.height)
        pickerView.delegate   = self
        pickerView.dataSource = self
        
        // 1.ここでpickerViewの大きさのuiviewを作成する（この時点ではまだ大きさと色を設定しているだけのuiview)
        let vi = UIView(frame: pickerView.bounds)
        vi.backgroundColor = UIColor.white
        // 2.uiviewの上にpikerviewを乗っける
        vi.addSubview(pickerView)
        
        // ここがポイント。1で作ったUIViewをtextFieldのinputView（本来はキーボードが表示されるはずのview）にのせる
        // そうすると、pikerが表示されるようになる
        textField.inputView = vi
        
        // ここがpikerviewを下から出したときの見た目設定。
        // キーボードにはツールバーが設定できるので、ツールバーを乗っけている。
        // done(終了＋完了）とcancel(データははいらない）のボタンをくっつけている
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        // pikerを終わらせる時のぼたん　donePressedを呼んでる
        let doneButton   = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(ViewController.donePressed))
        // キャンセルボタン cancelPressedを呼んでる
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.cancelPressed))
        // スペースを押したとき、のイベントは今回はないので何も設定しない
        let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        // pikerview（本来はキーボードが表示されるはずの場所だが、pikerviewで上書きしているので）にツールバーを設定する
        textField.inputAccessoryView = toolBar
    }
    // Done
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    // Cancel
    @objc func cancelPressed() {
        textField.text = ""
        view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // pikerviewで選択したデータをtextFieldのでテキストに反映する。
        textField.text = array[row]
    }

    @IBAction func showPikerViewBotton(_ sender: Any) {
    }
}

