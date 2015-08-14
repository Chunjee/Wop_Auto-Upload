<h1 align="center">
	<img src="http://i.imgur.com/KKygP0c.png" alt="Auto-Upload">
</h1>


### Overview
This program sends files to the CMS admin site. The purpose is to reduce human error and helps get Behind The Wall pictures and pdfs onto the website for customers quickly when there are only a few mins to post time.

Run Auto-Upload.exe
Uploader.exe is used as a background process and shouldn't be run manually.

### Example Use
Copy files from Marketing into the same directory as the executable.
- Run Auto-Upload
- Press "Rename BTW Files"
- Type in admin credentials
- Press Enter (Defaults to pressing the 'Upload' button)

### Settings
\Data\ contains images.txt and forms.txt; which dictate the upload directories for jpg and pdf files respectively. 
Warnings & Troubleshooting
Files are uploaded to all Platforms. TVG3, TVG2, PA, IA, NJ

### Dev Brief
Renames files and sends them to folders defined in settings

### Detailed Execution
Auto-Upload is a GUI and Uploader is launched with .adm credentials after they are entered and 'Upload' is pressed.
Uploader.exe sends all .jpg and .pdf files to the locations listed in the \Data\ folder of the tool.

### Technical Details
Latest version is 0.2
