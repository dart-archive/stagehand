// Copyright (c) 2017, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

const List<String> data = const [
  '.gitignore',
  'text',
  '''IyBGaWxlcyBhbmQgZGlyZWN0b3JpZXMgY3JlYXRlZCBieSBwdWIKLnBhY2thZ2VzCi5wdWIvCmJ1
aWxkLwojIFJlbW92ZSB0aGUgZm9sbG93aW5nIHBhdHRlcm4gaWYgeW91IHdpc2ggdG8gY2hlY2sg
aW4geW91ciBsb2NrIGZpbGUKcHVic3BlYy5sb2NrCgojIERpcmVjdG9yeSBjcmVhdGVkIGJ5IGRh
cnRkb2MKZG9jL2FwaS8K''',
  'CHANGELOG.md',
  'text',
  '''IyBDaGFuZ2Vsb2cKCiMjIDAuMC4xCgotIEluaXRpYWwgdmVyc2lvbiwgY3JlYXRlZCBieSBTdGFn
ZWhhbmQK''',
  'README.md',
  'text',
  '''IyBfX3Byb2plY3ROYW1lX18KCkEgc2FtcGxlIGNvbW1hbmQtbGluZSBhcHBsaWNhdGlvbi4KCkdl
bmVyYXRlZCBieSBTdGFnZWhhbmQuClNlZSB0aGUgW0xJQ0VOU0VdKGh0dHBzOi8vZ2l0aHViLmNv
bS9kYXJ0LWxhbmcvc3RhZ2VoYW5kL2Jsb2IvbWFzdGVyL0xJQ0VOU0UpLgo=''',
  'analysis_options.yaml',
  'text',
  '''YW5hbHl6ZXI6CiAgc3Ryb25nLW1vZGU6IHRydWUKIyAgIGV4Y2x1ZGU6CiMgICAgIC0gcGF0aC90
by9leGNsdWRlZC9maWxlcy8qKgoKIyBMaW50IHJ1bGVzIGFuZCBkb2N1bWVudGF0aW9uLCBzZWUg
aHR0cDovL2RhcnQtbGFuZy5naXRodWIuaW8vbGludGVyL2xpbnRzCmxpbnRlcjoKICBydWxlczoK
ICAgIC0gY2FuY2VsX3N1YnNjcmlwdGlvbnMKICAgIC0gaGFzaF9hbmRfZXF1YWxzCiAgICAtIGl0
ZXJhYmxlX2NvbnRhaW5zX3VucmVsYXRlZF90eXBlCiAgICAtIGxpc3RfcmVtb3ZlX3VucmVsYXRl
ZF90eXBlCiAgICAtIHRlc3RfdHlwZXNfaW5fZXF1YWxzCiAgICAtIHVucmVsYXRlZF90eXBlX2Vx
dWFsaXR5X2NoZWNrcwogICAgLSB2YWxpZF9yZWdleHBzCg==''',
  'bin/main.dart',
  'text',
  '''aW1wb3J0ICdwYWNrYWdlOl9fcHJvamVjdE5hbWVfXy9fX3Byb2plY3ROYW1lX18uZGFydCcgYXMg
X19wcm9qZWN0TmFtZV9fOwoKbWFpbihMaXN0PFN0cmluZz4gYXJndW1lbnRzKSB7CiAgcHJpbnQo
J0hlbGxvIHdvcmxkOiAke19fcHJvamVjdE5hbWVfXy5jYWxjdWxhdGUoKX0hJyk7Cn0K''',
  'lib/__projectName__.dart',
  'text',
  'aW50IGNhbGN1bGF0ZSgpIHsKICByZXR1cm4gNiAqIDc7Cn0K',
  'pubspec.yaml',
  'text',
  '''bmFtZTogX19wcm9qZWN0TmFtZV9fCmRlc2NyaXB0aW9uOiBBIHNhbXBsZSBjb21tYW5kLWxpbmUg
YXBwbGljYXRpb24uCnZlcnNpb246IDAuMC4xCiNob21lcGFnZTogaHR0cHM6Ly93d3cuZXhhbXBs
ZS5jb20KI2F1dGhvcjogX19hdXRob3JfXyA8ZW1haWxAZXhhbXBsZS5jb20+CgplbnZpcm9ubWVu
dDoKICBzZGs6ICc+PTEuMjAuMSA8Mi4wLjAnCgojZGVwZW5kZW5jaWVzOgojICBwYXRoOiBeMS40
LjEKCmRldl9kZXBlbmRlbmNpZXM6CiAgdGVzdDogXjAuMTIuMAo=''',
  'test/__projectName___test.dart',
  'text',
  '''aW1wb3J0ICdwYWNrYWdlOl9fcHJvamVjdE5hbWVfXy9fX3Byb2plY3ROYW1lX18uZGFydCc7Cmlt
cG9ydCAncGFja2FnZTp0ZXN0L3Rlc3QuZGFydCc7Cgp2b2lkIG1haW4oKSB7CiAgdGVzdCgnY2Fs
Y3VsYXRlJywgKCkgewogICAgZXhwZWN0KGNhbGN1bGF0ZSgpLCA0Mik7CiAgfSk7Cn0K'''
];
