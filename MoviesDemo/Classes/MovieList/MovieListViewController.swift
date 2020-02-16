import UIKit

class MovieListViewController: UITableViewController {

    private let segueID = "MovieDetail"
    
    private var activityIndicator: UIActivityIndicatorView!
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
        
        activityIndicator = UIActivityIndicatorView(style: .large )
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        
        let nib = UINib(nibName: MovieListTableViewCell.reuseID, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MovieListTableViewCell.reuseID)
    }
    
    private func load() {
        viewModel.progress.notify = { [weak self] (progress) in
            switch progress {
            case .ErrorResponse:
                DispatchQueue.main.async { [weak self] in
                    self?.showNetworkError()
                }
            case .End:
                DispatchQueue.main.async {
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.reloadData()
                }
            case .Start:
                self?.activityIndicator.isHidden = false
                self?.activityIndicator.startAnimating()
            }
        }
        
        viewModel.loadMoviesList()
    }
    
    private func showNetworkError() {
        let title = NSLocalizedString("Network", comment: "title")
        let messgae = NSLocalizedString("Response error", comment: "message")
        let alertText = NSLocalizedString("OK", comment: "Default action")
        let alert = UIAlertController(title: title, message: messgae, preferredStyle: .alert)
        let action = UIAlertAction(title: alertText, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    deinit {
        viewModel.cancelAllDownloads()
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: segueID, sender: indexPath.row)
    }
    
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
