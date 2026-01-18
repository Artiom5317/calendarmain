
extension UITextField {
    
    static func createTextField(placeHolder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeHolder
        tf.leftView = .init(frame: .init(x: 0, y: 0, width: 15, height: 0))
        tf.leftViewMode = .always
        return tf
    }
}
