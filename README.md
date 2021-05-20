# :repeat: 2021SINF RSync 
## Scripts to sync Directional and Bidirectional

The objective of this project is create two scripts that works with rsync for sincrhonize two folders. In the first case, we created a script that copies the content from one folder to another, but we had the problem of how to avoid losing it if the other folder was newer. We should also create another in which to check which of the two is newer and take it as a reference to copy in the other.

### Usage:
  1. Directional:
    - Download it and run `bash DirectionalSync.sh <origin> <destination>`
  3. Bidirectional:
    - Download it and run `bash BidirectionalSync.sh <folder> <folder>`

