setpref('Internet','SMTP_Server','smtp.robots.ox.ac.uk');
setpref('Internet','E_mail','asif@robots.ox.ac.uk');
setpref('Internet','SMTP_Username','asif');
setpref('Internet','SMTP_Password','INPUT PASSWORD HERE');

props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');
props.put('mail.smtp.starttls.enable','true');

