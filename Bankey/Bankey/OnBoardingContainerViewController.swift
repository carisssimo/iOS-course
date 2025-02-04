//
//  OnBoardingContainerViewController.swift
//  Bankey
//
//  Created by simonecaria on 31/01/25.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate : AnyObject  {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    
    weak var delegate : OnboardingContainerViewControllerDelegate?

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController {
        didSet {
        }
    }
    
    lazy var closeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: [])
        button.addTarget(self, action: #selector(closeButtonTapped), for: .primaryActionTriggered)
        button.setTitleColor(.systemBlue, for: [])
        return button
    }()
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(withImage: "delorean", withText: "Bankey is faster, easier to use, and has a brand new look and feeel that will make you feel like you are back in 1989")
        let page2 =  OnboardingViewController(withImage: "thumbs", withText: "Bankey is faster, easier to use, and has a brand new look and feeel that will make you feel like you are back in 1989")
        let page3 = OnboardingViewController(withImage: "world", withText: "Bankey is faster, easier to use, and has a brand new look and feeel that will make you feel like you are back in 1989")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        page1.delegate = self
        page2.delegate = self
        page3.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(closeButton)
        
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 56),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 26),
            
            
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

//MARK: OnBoardingViewControllerDelegate
extension  OnboardingContainerViewController : OnBoardingViewControllerDelegate {
    func didTapNextButton() {
        if let nextVC = getNextViewController(from: currentVC){
            pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
            currentVC = nextVC
        }
        
    }
    
    func didTapPrevButton() {
        if let prevVC = getPreviousViewController(from: currentVC){
            pageViewController.setViewControllers([prevVC], direction: .reverse, animated: true, completion: nil)
            currentVC = prevVC
        }
        
    }
    
    
}

//MARK: actions
extension OnboardingContainerViewController {
    @objc func closeButtonTapped() {
        delegate?.didFinishOnboarding()
    }
}

