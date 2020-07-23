install.packages("magick")
install.packages("image.libfacedetection", repos = "https://bnosac.github.io/drat")

library(magick)
library(image.libfacedetection)

#choose either manual image entry or automatic entry from a csv

#manual image entry
#replace the file names with your own file names
images = c("luke_S.jpg","bright.jpg","frodo_B.jpg","obama.jpg")

#Automatic entry from csv
setwd("your_directory") #replace "your_directory" with the path for your working directory where the csv is saved
image_df = as.data.frame(read.csv("csv_name",header=TRUE)) #replace "csv_name" with the name of your csv
images = as.character(image_df[["image_column_name"]]) #replace "image_column_name" with the name of the column your images are in

#cropping process
setwd("cropped_directory") #replace "cropped_directory" with the path for where you saved the "cropped" folder

for (i in 1:length(images)) {
  imageName = images[i]
  print(imageName)
  currentImage = image_read(imageName)
  faces = image_detect_faces(currentImage)
  x = faces$detections$x
  y = faces$detections$y
  width = faces$detections$width
  height = faces$detections$height
  img = image_crop(currentImage, geometry_area(x=(x/1.5),y=(y/2),width = (3*width),height = (3*height)))
  img = image_scale(img,"300x300")
  image_write(img, path = imageName, format = "jpg")
}
