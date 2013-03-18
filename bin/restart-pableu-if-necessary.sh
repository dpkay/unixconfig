#!/usr/bin/python

from email.mime.text import MIMEText
import smtplib
import socket
import subprocess
import sys
import urllib2

TIMEOUT=2

# Check if spiegel.de is online to see if we have reasonable
# connectivity to Germany. If that's not the case, there is no hope
# for any reasonable diagnosis.
try:
  urllib2.urlopen('http://www.spiegel.de/', timeout=TIMEOUT)
except (urllib2.URLError, socket.timeout) as e:
  sys.exit(0)

# If spiegel.de is online but we are not, let's restart apache and send
# a notification email.
try:
  urllib2.urlopen('http://wedding.kaeser-chen.com/', timeout=TIMEOUT)
except (urllib2.URLError, socket.timeout) as e:

  # Restart apache
  p = subprocess.Popen('ssh '
                       'dpk@pableu.net '
                       'sudo /usr/local/bin/restartapache.sh',
                       stdout=subprocess.PIPE,
                       stderr=subprocess.PIPE,
                       shell=True)
  stdout, stderr = p.communicate()

  # Compose message body
  msg_text = 'Original Error:\n' + str(e) + '\n\n'
  msg_text += 'Restarting... stdout:\n' + stdout + '\n\n'
  msg_text += 'and stderr:\n' + stderr + '\n\n'

  # Send email
  msg = MIMEText(msg_text)
  msg['Subject'] = 'wedding.kaeser-chen.com is down'
  msg['From'] = 'dpkay@google.com'
  msg['to'] = 'dominik.kaeser@gmail.com'
  s = smtplib.SMTP('localhost')
  s.sendmail(msg['From'], [msg['To']], msg.as_string())

  print "Timed out"
  sys.exit(1)

print "Online"

