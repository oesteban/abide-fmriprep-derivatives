

#---------------------------------
# New invocation of recon-all Tue Mar  3 11:08:00 CET 2026 
#--------------------------------------------
#@# Tessellate lh Tue Mar  3 11:08:01 CET 2026

 mri_pretess ../mri/filled.mgz 255 ../mri/norm.mgz ../mri/filled-pretess255.mgz 


 mri_tessellate ../mri/filled-pretess255.mgz 255 ../surf/lh.orig.nofix 


 rm -f ../mri/filled-pretess255.mgz 


 mris_extract_main_component ../surf/lh.orig.nofix ../surf/lh.orig.nofix 

#--------------------------------------------
#@# Smooth1 lh Tue Mar  3 11:08:06 CET 2026

 mris_smooth -nw -seed 1234 ../surf/lh.orig.nofix ../surf/lh.smoothwm.nofix 

#--------------------------------------------
#@# Inflation1 lh Tue Mar  3 11:08:09 CET 2026

 mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix 

#--------------------------------------------
#@# QSphere lh Tue Mar  3 11:08:27 CET 2026

 mris_sphere -q -p 6 -a 128 -seed 1234 ../surf/lh.inflated.nofix ../surf/lh.qsphere.nofix 

#@# Fix Topology lh Tue Mar  3 11:10:37 CET 2026

 mris_fix_topology -mgz -sphere qsphere.nofix -inflated inflated.nofix -orig orig.nofix -out orig.premesh -ga -seed 1234 sub-v1s19x0051298_ses-1 lh 


 mris_euler_number ../surf/lh.orig.premesh 


 mris_remesh --remesh --iters 3 --input /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/surf/lh.orig.premesh --output /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/surf/lh.orig 


 mris_remove_intersection ../surf/lh.orig ../surf/lh.orig 


 rm -f ../surf/lh.inflated 

#--------------------------------------------
#@# AutoDetGWStats lh Tue Mar  3 11:12:35 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.lh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/lh.orig.premesh
#--------------------------------------------
#@# WhitePreAparc lh Tue Mar  3 11:12:39 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --wm wm.mgz --threads 16 --invol brain.finalsurfs.mgz --lh --i ../surf/lh.orig --o ../surf/lh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
#--------------------------------------------
#@# CortexLabel lh Tue Mar  3 11:17:16 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 0 ../label/lh.cortex.label
#--------------------------------------------
#@# CortexLabel+HipAmyg lh Tue Mar  3 11:17:34 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 1 ../label/lh.cortex+hipamyg.label
#--------------------------------------------
#@# Smooth2 lh Tue Mar  3 11:17:52 CET 2026

 mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm 

#--------------------------------------------
#@# Inflation2 lh Tue Mar  3 11:17:55 CET 2026

 mris_inflate ../surf/lh.smoothwm ../surf/lh.inflated 

#--------------------------------------------
#@# Curv .H and .K lh Tue Mar  3 11:18:16 CET 2026

 mris_curvature -w -seed 1234 lh.white.preaparc 


 mris_curvature -seed 1234 -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated 

#--------------------------------------------
#@# Sphere lh Tue Mar  3 11:19:10 CET 2026

 mris_sphere -seed 1234 ../surf/lh.inflated ../surf/lh.sphere 

#--------------------------------------------
#@# Surf Reg lh Tue Mar  3 11:22:29 CET 2026

 mris_register -curv ../surf/lh.sphere /opt/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/lh.sphere.reg 


 ln -sf lh.sphere.reg lh.fsaverage.sphere.reg 

#--------------------------------------------
#@# Jacobian white lh Tue Mar  3 11:27:44 CET 2026

 mris_jacobian ../surf/lh.white.preaparc ../surf/lh.sphere.reg ../surf/lh.jacobian_white 

#--------------------------------------------
#@# AvgCurv lh Tue Mar  3 11:27:45 CET 2026

 mrisp_paint -a 5 /opt/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/lh.sphere.reg ../surf/lh.avg_curv 

#-----------------------------------------
#@# Cortical Parc lh Tue Mar  3 11:27:46 CET 2026

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-v1s19x0051298_ses-1 lh ../surf/lh.sphere.reg /opt/freesurfer/average/lh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.annot 

#--------------------------------------------
#@# WhiteSurfs lh Tue Mar  3 11:27:58 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --seg aseg.presurf.mgz --threads 16 --wm wm.mgz --invol brain.finalsurfs.mgz --lh --i ../surf/lh.white.preaparc --o ../surf/lh.white --white --nsmooth 0 --rip-label ../label/lh.cortex.label --rip-bg --rip-surf ../surf/lh.white.preaparc --aparc ../label/lh.aparc.annot
#--------------------------------------------
#@# T1PialSurf lh Tue Mar  3 11:32:12 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --seg aseg.presurf.mgz --threads 16 --wm wm.mgz --invol brain.finalsurfs.mgz --lh --i ../surf/lh.white --o ../surf/lh.pial.T1 --pial --nsmooth 0 --rip-label ../label/lh.cortex+hipamyg.label --pin-medial-wall ../label/lh.cortex.label --aparc ../label/lh.aparc.annot --repulse-surf ../surf/lh.white --white-surf ../surf/lh.white
#@# white curv lh Tue Mar  3 11:36:41 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
#@# white area lh Tue Mar  3 11:36:43 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
#@# pial curv lh Tue Mar  3 11:36:44 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
#@# pial area lh Tue Mar  3 11:36:47 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
#@# thickness lh Tue Mar  3 11:36:48 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
#@# area and vertex vol lh Tue Mar  3 11:37:28 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness

#-----------------------------------------
#@# Curvature Stats lh Tue Mar  3 11:37:31 CET 2026

 mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm sub-v1s19x0051298_ses-1 lh curv sulc 

#-----------------------------------------
#@# Cortical Parc 2 lh Tue Mar  3 11:37:34 CET 2026

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-v1s19x0051298_ses-1 lh ../surf/lh.sphere.reg /opt/freesurfer/average/lh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.a2009s.annot 

#-----------------------------------------
#@# Cortical Parc 3 lh Tue Mar  3 11:37:51 CET 2026

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-v1s19x0051298_ses-1 lh ../surf/lh.sphere.reg /opt/freesurfer/average/lh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.DKTatlas.annot 

#-----------------------------------------
#@# WM/GM Contrast lh Tue Mar  3 11:38:03 CET 2026

 pctsurfcon --s sub-v1s19x0051298_ses-1 --lh-only 



#---------------------------------
# New invocation of recon-all Tue Mar  3 12:22:25 CET 2026 
#--------------------------------------------
#@# AutoDetGWStats lh Tue Mar  3 12:22:26 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_autodet_gwstats --o ../surf/autodet.gw.stats.lh.dat --i brain.finalsurfs.mgz --wm wm.mgz --surf ../surf/lh.orig.premesh
  Update not needed
#--------------------------------------------
#@# WhitePreAparc lh Tue Mar  3 12:22:26 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --adgws-in ../surf/autodet.gw.stats.lh.dat --wm wm.mgz --threads 16 --invol brain.finalsurfs.mgz --lh --i ../surf/lh.orig --o ../surf/lh.white.preaparc --white --seg aseg.presurf.mgz --nsmooth 5
   Update not needed
#--------------------------------------------
#@# CortexLabel lh Tue Mar  3 12:22:26 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 0 ../label/lh.cortex.label
   Update not needed
#--------------------------------------------
#@# CortexLabel+HipAmyg lh Tue Mar  3 12:22:26 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mri_label2label --label-cortex ../surf/lh.white.preaparc aseg.presurf.mgz 1 ../label/lh.cortex+hipamyg.label
   Update not needed
#@# white curv lh Tue Mar  3 12:22:26 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --curv-map ../surf/lh.white 2 10 ../surf/lh.curv
   Update not needed
#@# white area lh Tue Mar  3 12:22:26 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --area-map ../surf/lh.white ../surf/lh.area
   Update not needed
#@# pial curv lh Tue Mar  3 12:22:26 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --curv-map ../surf/lh.pial 2 10 ../surf/lh.curv.pial
   Update not needed
#@# pial area lh Tue Mar  3 12:22:26 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --area-map ../surf/lh.pial ../surf/lh.area.pial
   Update not needed
#@# thickness lh Tue Mar  3 12:22:26 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#@# area and vertex vol lh Tue Mar  3 12:22:26 CET 2026
cd /out/sourcedata/freesurfer/sub-v1s19x0051298_ses-1/mri
mris_place_surface --thickness ../surf/lh.white ../surf/lh.pial 20 5 ../surf/lh.thickness
   Update not needed
#-----------------------------------------
#@# Parcellation Stats lh Tue Mar  3 12:22:26 CET 2026

 mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub-v1s19x0051298_ses-1 lh white 


 mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.pial.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub-v1s19x0051298_ses-1 lh pial 

#-----------------------------------------
#@# Parcellation Stats 2 lh Tue Mar  3 12:23:01 CET 2026

 mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.a2009s.stats -b -a ../label/lh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub-v1s19x0051298_ses-1 lh white 

#-----------------------------------------
#@# Parcellation Stats 3 lh Tue Mar  3 12:23:21 CET 2026

 mris_anatomical_stats -th3 -mgz -noglobal -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.DKTatlas.stats -b -a ../label/lh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub-v1s19x0051298_ses-1 lh white 

#--------------------------------------------
#@# BA_exvivo Labels lh Tue Mar  3 12:23:38 CET 2026

 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA1_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA1_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA2_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA2_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA3a_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA3a_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA3b_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA3b_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA4a_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA4a_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA4p_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA4p_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA6_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA6_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA44_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA44_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA45_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA45_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.V1_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.V1_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.V2_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.V2_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.MT_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.MT_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.entorhinal_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.entorhinal_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.perirhinal_exvivo.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.perirhinal_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.FG1.mpm.vpnl.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.FG1.mpm.vpnl.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.FG2.mpm.vpnl.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.FG2.mpm.vpnl.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.FG3.mpm.vpnl.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.FG3.mpm.vpnl.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.FG4.mpm.vpnl.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.FG4.mpm.vpnl.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.hOc1.mpm.vpnl.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.hOc1.mpm.vpnl.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.hOc2.mpm.vpnl.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.hOc2.mpm.vpnl.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.hOc3v.mpm.vpnl.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.hOc3v.mpm.vpnl.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.hOc4v.mpm.vpnl.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.hOc4v.mpm.vpnl.label --hemi lh --regmethod surface 


 mris_label2annot --s sub-v1s19x0051298_ses-1 --ctab /opt/freesurfer/average/colortable_vpnl.txt --hemi lh --a mpm.vpnl --maxstatwinner --noverbose --l lh.FG1.mpm.vpnl.label --l lh.FG2.mpm.vpnl.label --l lh.FG3.mpm.vpnl.label --l lh.FG4.mpm.vpnl.label --l lh.hOc1.mpm.vpnl.label --l lh.hOc2.mpm.vpnl.label --l lh.hOc3v.mpm.vpnl.label --l lh.hOc4v.mpm.vpnl.label 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA1_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA1_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA2_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA2_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA3a_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA3a_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA3b_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA3b_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA4a_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA4a_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA4p_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA4p_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA6_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA6_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA44_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA44_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.BA45_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.BA45_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.V1_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.V1_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.V2_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.V2_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.MT_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.MT_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.entorhinal_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.entorhinal_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /out/sourcedata/freesurfer/fsaverage/label/lh.perirhinal_exvivo.thresh.label --trgsubject sub-v1s19x0051298_ses-1 --trglabel ./lh.perirhinal_exvivo.thresh.label --hemi lh --regmethod surface 


 mris_label2annot --s sub-v1s19x0051298_ses-1 --hemi lh --ctab /opt/freesurfer/average/colortable_BA.txt --l lh.BA1_exvivo.label --l lh.BA2_exvivo.label --l lh.BA3a_exvivo.label --l lh.BA3b_exvivo.label --l lh.BA4a_exvivo.label --l lh.BA4p_exvivo.label --l lh.BA6_exvivo.label --l lh.BA44_exvivo.label --l lh.BA45_exvivo.label --l lh.V1_exvivo.label --l lh.V2_exvivo.label --l lh.MT_exvivo.label --l lh.perirhinal_exvivo.label --l lh.entorhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose 


 mris_label2annot --s sub-v1s19x0051298_ses-1 --hemi lh --ctab /opt/freesurfer/average/colortable_BA.txt --l lh.BA1_exvivo.thresh.label --l lh.BA2_exvivo.thresh.label --l lh.BA3a_exvivo.thresh.label --l lh.BA3b_exvivo.thresh.label --l lh.BA4a_exvivo.thresh.label --l lh.BA4p_exvivo.thresh.label --l lh.BA6_exvivo.thresh.label --l lh.BA44_exvivo.thresh.label --l lh.BA45_exvivo.thresh.label --l lh.V1_exvivo.thresh.label --l lh.V2_exvivo.thresh.label --l lh.MT_exvivo.thresh.label --l lh.perirhinal_exvivo.thresh.label --l lh.entorhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose 


 mris_anatomical_stats -th3 -mgz -noglobal -f ../stats/lh.BA_exvivo.stats -b -a ./lh.BA_exvivo.annot -c ./BA_exvivo.ctab sub-v1s19x0051298_ses-1 lh white 


 mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.thresh.stats -noglobal -b -a ./lh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub-v1s19x0051298_ses-1 lh white 

