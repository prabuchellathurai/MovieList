import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var genreLabel: UILabel!
    @IBOutlet weak private var posterImageView: UIImageView!
    
    var viewModel: IMovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateText()
    }
    
    private func updateText() {
        nameLabel.text = viewModel?.name
        genreLabel.text = viewModel?.genre
        posterImageView.image = viewModel?.posterImage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
