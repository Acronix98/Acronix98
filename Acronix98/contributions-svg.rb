require "nokogiri"
require "open-uri"
url = "https://github.com/#{params['Acronix98']}"
document = Nokogiri::HTML(open(url))
contrib_boxes = document.css('svg.js-calendar-graph-svg')[0]
contrib_boxes['xmlns']="http://www.w3.org/2000/svg"
width = (params['width']||54*13-2).to_i
height = (params['height']||89).to_i
contrib_boxes.css('text').remove
contrib_boxes['width']=(width+11).to_s+'px'
contrib_boxes['height']=(height+11).to_s+'px'
contrib_boxes.at_css('>g')['transform']='translate(0, 0)'
day_boxes = contrib_boxes.css('g>g')
day_boxes.each_with_index{|box, m|
  box['transform']="translate(#{m*((width-53*2)/54+2)}, 0)"
  box.css('rect.day').each_with_index{|col,n|
    col['height']=(height-12)/7
    col['width']=(width-53*2)/54
    col['y'] = col['y'].to_i-(11-(height-12)/7)*col['y'].to_i/13
  }

}
{
  :body => contrib_boxes.to_html,
  :content_type => 'image/svg+xml;charset=utf-8'
}
