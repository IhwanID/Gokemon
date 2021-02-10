//
//  DetailViewController.swift
//  Gokemon
//
//  Created by Ihwan ID on 09/02/21.
//

import UIKit

class DetailViewController: UIViewController {

    var pokemon: Pokemon?

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var cardType: UIView!

    @IBOutlet weak var imageType: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.applyGradient(colours: [UIColor(red: 77.0/255.0, green: 130.0/255.0, blue: 231.0/255.0, alpha: 1.0), UIColor(red: 97.0/255.0, green: 195/255.0, blue: 233.0/255.0, alpha: 1.0)])
        let url = URL(string: "https://pokeres.bastionbot.org/images/pokemon/\(pokemon!.id).png")!
        photo.kf.setImage(with: url)
        name.text = pokemon?.name.capitalizingFirstLetter()
        name.textColor = .black
        type.textColor = .white
        type.text = pokemon?.type.first?.capitalizingFirstLetter()
        imageType.image = UIImage(named: pokemon?.type.first?.capitalized ?? "")
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 50
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardType.backgroundColor = UIColor(red: 97.0/255.0, green: 195/255.0, blue: 233.0/255.0, alpha: 1.0)
        cardType.layer.cornerRadius = 20
        cardType.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }

}

extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x : 0.0, y : 0.5)
        gradient.endPoint = CGPoint(x :1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
