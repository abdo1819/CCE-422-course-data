CREATE PLUGGABLE DATABASE sheet1 
ADMIN USER pdb_a  2  dmin IDENTIFIED BY SysPassword1 
FILE_NAME_CONVERT  3   = ('/opt/oracle/oradata/FREE/pdbseed/', '/opt/oracle/oradata/SHEET1/');