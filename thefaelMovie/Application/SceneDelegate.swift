import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let service = URLSessionService()
        let interactor = PopularMoviesInteractor(service: service)

        let PopularMoviesVC = PopularMoviesViewController(interactor: interactor)
        PopularMoviesVC.title = "Popular"
        let FavoriteMoviesVC = FavoriteMoviesViewController()
        FavoriteMoviesVC.title = "Favorite"
        let tabBar = UITabBarController()
        let navigationController = UINavigationController(rootViewController: PopularMoviesVC)
        tabBar.setViewControllers([navigationController, FavoriteMoviesVC], animated: true)
        window.rootViewController = tabBar

        self.window = window
        window.makeKeyAndVisible()
    }
}

