import UIKit

class MovieViewController: UIViewController {
    var image = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupImageView()
    }

    func setupImageView() {
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        image.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}
