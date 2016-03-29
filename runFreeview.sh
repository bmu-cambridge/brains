# just a little function that loads all the freesurfer/freeview files in one go after you set the working directory
#!/bin/sh

SUBJECTS_DIR=/raw/SURFER # change this into your default directory

while [ 0 -eq 0 ]; do
echo "Enter the filename and press [ENTER]: "
read filename

sub=$filename

freeview -v ${SUBJECTS_DIR}/$sub/mri/T1.mgz \
            ${SUBJECTS_DIR}/$sub/mri/brainmask.mgz \
         -f ${SUBJECTS_DIR}/$sub/surf/lh.white:edgecolor=yellow \
            ${SUBJECTS_DIR}/$sub/surf/lh.pial:edgecolor=red \
            ${SUBJECTS_DIR}/$sub/surf/rh.white:edgecolor=yellow \
            ${SUBJECTS_DIR}/$sub/surf/rh.pial:edgecolor=red \
            ${SUBJECTS_DIR}/$sub/surf/lh.inflated:visible=0 \
            ${SUBJECTS_DIR}/$sub/surf/rh.inflated:visible=0 
done
