//
//  Created by Mihlali Mazomba on 2023/10/25.
//

import UIKit
import SwiftUI
import Combine

class MovieListViewController: UIViewController {
    
    private var backDropCellRegistration: UICollectionView.CellRegistration<MovieCollectionViewBackDropCell, Movie>!
    private var posterCellRegistration: UICollectionView.CellRegistration<MovieCollectionViewPosterCell, Movie>!
    private var headerRegistration: UICollectionView.SupplementaryRegistration<HeaderView>!
    private var dataSource: UICollectionViewDiffableDataSource<MovieCategoryType, Movie>!
    
    private  var activityView = UIActivityIndicatorView()
    
    private var cancellable = Set<AnyCancellable>()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var viewModel = MovieListViewModel(movieService: MovieListServiceConcrete())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.title
        setupActivityIndicator()
        setupCollectionView()
        setupDataSource()
        bind()
        viewModel.fetchMoviesList()
        setupSnapShop(movieSections: viewModel.movieSections)
    }
    
    private func bind() {
        viewModel
            .refreshViewPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.showFailureMessage(withError: error)
                }
            } receiveValue: {[weak self] _ in
                guard  let self = self else { return }
                self.activityView.stopAnimating()
                self.setupSnapShop(movieSections: self.viewModel.movieSections)
            }.store(in: &cancellable)
    }
    
    private func setupActivityIndicator() {
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        activityView.style = .large
        activityView.startAnimating()
        self.view.addSubview(activityView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(section: topRatedLayoutSection())
    }
    
    private func topRatedLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension:
                .fractionalHeight(0.4))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
    }
    
    private func setupCollectionView() {
        
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.collectionViewLayout = createLayout()
        
        view.addSubview(collectionView)
        
        posterCellRegistration = UICollectionView.CellRegistration(handler: { (cell: MovieCollectionViewPosterCell, _, movie: Movie) in
            cell.configure(with: movie, parent: self)
        })
        
        backDropCellRegistration = UICollectionView.CellRegistration(handler: { (cell: MovieCollectionViewBackDropCell , _ ,  movie: Movie) in
            cell.configure(with: movie, parent: self)
        })
        
        headerRegistration = UICollectionView
            .SupplementaryRegistration(
                elementKind: UICollectionView.elementKindSectionHeader, handler: { [weak self] (header: HeaderView, _ , indexPath) in
                    guard let self = self else { return }
                    let title = self.viewModel.movieSections?[indexPath.section].categoryType.description ?? ""
                    header.headerTitle = title
                })
    }
    
    private func setupDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: {[weak self] (collectionView, indexPath, movie: Movie) -> UICollectionViewCell? in
                
                guard let self = self else { return  nil}
                
                guard let sectionIdentifier = self.dataSource.snapshot().sectionIdentifier(containingItem: movie) else { return nil}
                
                switch sectionIdentifier {
                case .topRated:
                    return collectionView.dequeueConfiguredReusableCell(using: self.posterCellRegistration, for: indexPath, item: movie)
                default:
                    return collectionView.dequeueConfiguredReusableCell(using: self.backDropCellRegistration, for: indexPath, item: movie)
                }
            })
        
        dataSource.supplementaryViewProvider =  { [weak self ]
            (collectionView, kind , IndexPath) -> UICollectionReusableView in
            guard let self = self else { return  UICollectionReusableView() }
            let headerView = collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: IndexPath)
            return headerView
            
        }
    }
    
    private func setupSnapShop(movieSections: [MoviesSections]?) {
        
        var snapshot = NSDiffableDataSourceSnapshot<MovieCategoryType, Movie>()
        
        movieSections?.forEach { movieSection in
            snapshot.appendSections([movieSection.categoryType])
            snapshot.appendItems(movieSection.movies, toSection: movieSection.categoryType)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieItem = dataSource.itemIdentifier(for: indexPath) else { return }
        let detailsViewController = UIHostingController(rootView: MovieDetailsView(movie: movieItem))
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

struct MovieListViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: MovieListViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct MovieListViewController_Previews: PreviewProvider {
    
    static var previews: some View {
        MovieListViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}
