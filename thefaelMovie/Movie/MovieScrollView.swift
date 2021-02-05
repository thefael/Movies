import UIKit

class MovieScrollView: UIView {
    var scrollView: UIScrollView {
        backgroundColor = .red
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = Constants.screen
        view.contentSize = Constants.screen.size
        return view
    }
}
