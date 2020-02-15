import UIKit

class MovieListViewController: UITableViewController {

    private let segueID = "MovieDetail"
    private let viewModel: MovieListViewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetup()
        load()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    private func initialUISetup() {
        navigationItem.title = viewModel.title
        let nib = UINib(nibName: MovieListTableViewCell.reuseID, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MovieListTableViewCell.reuseID)
    }
    
    private func load() {
        
        viewModel.progress.notify = { (progress) in
            switch progress {
            case .End:
                DispatchQueue.main.async {
                 self.tableView.reloadData()
                }
            default:
                break
            }
        }
        
        viewModel.loadMoviesList()
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movie.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reuseID) as? MovieListTableViewCell
        let movieCellViewModel = viewModel.objectAtIndex(index: indexPath.row)
        cell!.setViewModel(movieCellViewModel)
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: segueID, sender: indexPath.row)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as? MovieDetailViewController
        let index = sender as? Int
        if let detailViewController = destination, let selectedIndex = index {
            detailViewController.viewModel = MovieDetailViewModel(movie: viewModel[selectedIndex])
        }
    }

}
