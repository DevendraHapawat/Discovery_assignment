# This clas contains locators and methods of Home Page.
class HomePage
  @recommended_videos_heading = '.layoutSection__heading'
  @recommended_section = '.layout-section.ShowCarousel.layoutSection__main'
  @videos_list = '.carousel-tile-wrapper.carousel__tileWrapper'
  @recommended_videos = '.layout-section.ShowCarousel'
  @recommended_list = '.carousel-tile-wrapper.carousel__tileWrapper'
  @add_favorite_button = '.tooltip-wrapper'
  @recommended_text = 'RECOMMENDED'
  @video_text = '.showTileSquare__title  div'
  @video_desciption = '.showTileSquare__description'
  class << self
    # function to navigate on home page.
    def navigate_to_home
      visit '/'
      page.driver.browser.manage.window.maximize
    end

    # function for Scrolling to recommended video
    def scroll_to_recommended_videos
      ele = find(@recommended_videos_heading, text: @recommended_text)
      CommonHelper.scroll_to(ele)
    end

    # function for adding to recommended video
    def add_recommended_videos
      element = find(@recommended_section, text: @recommended_text)
      videos = element.all(@recommended_list)
      video_title = {}
      video_desciption = {}
      videos.each_with_index do |video, index|
        break if index > 1
        page.driver.browser.action.move_to(video.native).perform
        video_title[index] = video.find(@video_text).text
        video_desciption[index] = video.find(@video_desciption).text
        video.find(@add_favorite_button).click
        page.has_css?@video_desciption
      end
      [video_title,video_desciption]
     end
  end
end
