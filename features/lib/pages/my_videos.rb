# This clas contains locators and methods of my video page.
class MyVideos
  @fav_videos_section = '.layout-section.FavoriteShowsCarousel.layoutSection__main'
  @my_videos_text = '.myVideosLayout__title'
  @my_video_url = '/my-videos'
  @videos_list = '.carousel-tile-wrapper.carousel__tileWrapper'
  @video_text = '.showTileSquare__title  div'
  @video_desciption = '.showTileSquare__description'
  class << self
   # function to navigate to my videos.
   def navigate_to_my_videos
     visit @my_video_url
     wait_for_videos
   end

   # function for videos to load on page.
   def wait_for_videos
     loop do
       break if page.has_css? @my_videos_text
     end
   end

   # Function to return selected video text.
   def fetch_video_title
     my_video = find(@fav_videos_section)
     fav_videos = my_video.all(@videos_list)
     fav_title = {}
     fav_desc = {}
     fav_videos.each_with_index do |fav, index|
       CommonHelper.scroll_to(fav)
       page.driver.browser.action.move_to(fav.native).perform
       fav_title[index] = fav.find(@video_text).text
       fav_desc[index] = fav.find(@video_desciption).text
     end
     [fav_title,fav_desc]
   end
  end
end
