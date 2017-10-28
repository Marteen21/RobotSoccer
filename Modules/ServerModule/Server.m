%Accept a connection from any machine on port 30000.
t = tcpip('0.0.0.0', 30000, 'NetworkRole', 'server');
%Open a connection. This will not return until a connection is received.
fopen(t);