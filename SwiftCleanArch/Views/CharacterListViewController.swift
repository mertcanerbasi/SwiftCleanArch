import UIKit

class CharacterListViewController: BaseViewController<CharacterListViewModel>, UITableViewDataSource, UITableViewDelegate {

    private var tableView: UITableView!
    var coordinator: AppCoordinator? // Reference to the coordinator

    // Custom initializer to inject the ViewModel
    init(viewModel: CharacterListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel() // Bind ViewModel after setting up the view
        viewModel.fetchCharacters()
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterCell")
        view.addSubview(tableView)
        view.backgroundColor = .white

        // Constrain the table view to the safe area of the view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func bindViewModel() {
        super.bindViewModel()

        viewModel.charactersDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - UITableViewDataSource & UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterTableViewCell
        let characterViewModel = viewModel.characterViewModel(at: indexPath.row)
        cell.configure(with: characterViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.showCharacterDetail(character: character) // Notify coordinator
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
