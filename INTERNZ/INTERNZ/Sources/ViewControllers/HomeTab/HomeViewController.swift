//
//  HomeViewController.swift
//  INTERNZ
//
//  Created by 최은지 on 24/12/2019.
//  Copyright © 2019 최은지. All rights reserved.
//

import UIKit
import CHIPageControl

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var bannerCV: UICollectionView!
    @IBOutlet weak var paging: CHIPageControlAleppo!
    @IBOutlet weak var profileBannerCV: UICollectionView!
    @IBOutlet weak var storyWholeView: UIView!
    
    @IBOutlet weak var storyStackView: UIStackView!
    
    
    @IBOutlet weak var storyTitleLabel1: UILabel!
    @IBOutlet weak var storyTitleLabel2: UILabel!
    @IBOutlet weak var storyTitleLabel3: UILabel!
    @IBOutlet weak var storyTitleLabel4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.homeView.backgroundColor = UIColor(patternImage: UIImage(named: "bannerImg")!)
        
        // tab bar item 의 title 설정
        if let downcastStrings = self.tabBarController?.tabBar.items
        {
            downcastStrings[0].title = "홈"
            downcastStrings[1].title = "공고"
            downcastStrings[2].title = "스토리"
            downcastStrings[3].title = "프로필"
        }
        
        // tab bar item image 설정
        self.tabBarController?.tabBar.items![0].image = UIImage(named: "tabHomeActiveIc")
        self.tabBarController?.tabBar.items![1].image = UIImage(named: "tabNoticeIc")
        self.tabBarController?.tabBar.items![2].image = UIImage(named: "tabStoryIc")
        self.tabBarController?.tabBar.items![3].image = UIImage(named: "tabProfileIc")
        
        // tab bar color 설정
        self.tabBarController?.tabBar.selectedImageTintColor = UIColor.marigold
        
        // 맞춤 공고 banner 설정
        bannerCV.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.007)
        
        // 공고 collection view 에 들어갈 sample data setting
        setBanner()
        bannerCV.delegate = self
        bannerCV.dataSource = self
        bannerCV.isPagingEnabled = true
        
        // 프로필 banner 설정
        profileBannerCV.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.007)
        
        // 프로필 collection view 에 들어갈 sample profile data setting
        setProfileBanner()
        
        profileBannerCV.delegate = self
        profileBannerCV.dataSource = self
        
        storyWholeView.setViewShadow()
        
        self.storyStackView.layer.cornerRadius = 5
        
        setStoryTitle()
        
        
        
        
    }
    
    
    func setStoryTitle(){
        self.storyTitleLabel1.setMultiLine()
        self.storyTitleLabel2.setMultiLine()
        self.storyTitleLabel3.setMultiLine()
        self.storyTitleLabel4.setMultiLine()
        
        self.storyTitleLabel1.text = "영화번역가는 AI 때문에 사라질 직업인가."
        self.storyTitleLabel2.text = "코딩 테스트부터 코딩 인턴까지 코딩에 대한 A to Z"
        self.storyTitleLabel3.text = "디자인 인턴 합격까지의 과정! 서류부터 면접까지."
        self.storyTitleLabel4.text = "비전공자가 알아본 외국계 디자인 인턴과정"
       
    }
    
    private func setBanner(){
        let banner1 = Banner(corpImgName: "corpImg1", corpName: "NAVER", jobName: "Clova NLP 기술 개발 인턴", day: "D - 6")
        let banner2 = Banner(corpImgName: "corpImg1", corpName: "지멘스", jobName: "IT Infrastructure 인턴", day: "D - 28")
        let banner3 = Banner(corpImgName: "corpImg1", corpName: "INNOBABY", jobName: "미국 시카고 INNOBABY 디자인 인턴", day: "D + 3")
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.bannerList = [banner1, banner2, banner3]
    }
    
    private func setProfileBanner(){
        let profileBanner1 = ProfileBanner(profileImgName: "profileImg1", userName: "은지짱", introduce: "구글의 개발자가 되고싶은 오투입니다!! 아요를 꽉 잡는 개발자가 되고싶습니다:)")
        let profileBanner2 = ProfileBanner(profileImgName: "profileImg1", userName: "주연짱", introduce: "국정원 정보 보안 분야로 입사하는 것이 꿈인 우주입니다:) 저는 보안과 서버를 접목하고 싶습니다!!")
        let profileBanner3 = ProfileBanner(profileImgName: "profileImg1", userName: "박정민", introduce: "구글의 개발자가 되고싶은 오투입니다!! 아요를 꽉 잡는 개발자가 되고싶습니다:)")
        let profileBanner4 = ProfileBanner(profileImgName: "profileImg1", userName: "정우성", introduce: "국정원 정보 보안 분야로 입사하는 것이 꿈인 우주입니다:) 저는 보안과 서버를 접목하고 싶습니다!!")
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        delegate?.profileBannerList = [profileBanner1, profileBanner2, profileBanner3, profileBanner4]
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return 0 }
        
        if collectionView == bannerCV {
            return delegate.bannerList.count
        } else {
            return delegate.profileBannerList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == bannerCV {
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
            
            guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return UICollectionViewCell() }
            
            let banner = delegate.bannerList[indexPath.row]
            
            bannerCell.corpImage?.image = banner.corpImg
            bannerCell.corpNameLabel.text = banner.corpName
            bannerCell.jobLabelName.text = banner.jobName
            bannerCell.dateLabel.text = banner.day
            
            bannerCell.cellView.setViewShadow()
            
            return bannerCell
            
        } else {
            
            let profileBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileBannerCell", for: indexPath) as! ProfileBannerCell
            
            guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return UICollectionViewCell() }
            
            let profileBanner = delegate.profileBannerList[indexPath.row]
            
            profileBannerCell.profileImage?.image = profileBanner.profileImg
            profileBannerCell.nameLabel.text = profileBanner.userName
            profileBannerCell.introduceLabel.text = profileBanner.introduce
            
            profileBannerCell.cellView.setViewShadow()
            
            return profileBannerCell
        }
    }
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = bannerCV.contentOffset.x
        let w = bannerCV.bounds.size.width
        let currentPage = Int(ceil(x/w))
        print(currentPage)
        self.paging.set(progress: currentPage, animated: true)
    }
}
