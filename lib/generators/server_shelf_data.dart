// Copyright (c) 2016, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

const List<String> data = const [
  ".analysis_options",
  "text",
  """IyBUaGlzIGZpbGUgYWxsb3dzIHlvdSB0byBjb25maWd1cmUgdGhlIERhcnQgYW5hbHl6ZXIuCiMK
IyBUaGUgY29tbWVudGVkIHBhcnQgYmVsb3cgaXMganVzdCBmb3IgaW5zcGlyYXRpb24uIFJlYWQg
dGhlIGd1aWRlIGhlcmU6CiMgICBodHRwczovL3d3dy5kYXJ0bGFuZy5vcmcvZ3VpZGVzL2xhbmd1
YWdlL2FuYWx5c2lzLW9wdGlvbnMKCiMgYW5hbHl6ZXI6CiMgICBzdHJvbmctbW9kZTogdHJ1ZQoj
ICAgZXhjbHVkZToKIyAgICAgLSBwYXRoL3RvL2V4Y2x1ZGVkL2ZpbGVzLyoqCiMgbGludGVyOgoj
ICAgcnVsZXM6CiMgICAgICMgc2VlIGNhdGFsb2cgaGVyZTogaHR0cDovL2RhcnQtbGFuZy5naXRo
dWIuaW8vbGludGVyL2xpbnRzLwojICAgICAtIGhhc2hfYW5kX2VxdWFscwo=""",
  ".gitignore",
  "text",
  """IyBGaWxlcyBhbmQgZGlyZWN0b3JpZXMgY3JlYXRlZCBieSBwdWIKLnBhY2thZ2VzCi5wdWIvCmJ1
aWxkLwpwYWNrYWdlcwojIFJlbW92ZSB0aGUgZm9sbG93aW5nIHBhdHRlcm4gaWYgeW91IHdpc2gg
dG8gY2hlY2sgaW4geW91ciBsb2NrIGZpbGUKcHVic3BlYy5sb2NrCgojIEZpbGVzIGNyZWF0ZWQg
YnkgZGFydDJqcwoqLmRhcnQuanMKKi5wYXJ0LmpzCiouanMuZGVwcwoqLmpzLm1hcAoqLmluZm8u
anNvbgoKIyBEaXJlY3RvcnkgY3JlYXRlZCBieSBkYXJ0ZG9jCmRvYy9hcGkvCgojIEpldEJyYWlu
cyBJREVzCi5pZGVhLwoqLmltbAoqLmlwcgoqLml3cwo=""",
  "CHANGELOG.md",
  "text",
  """IyBDaGFuZ2Vsb2cKCiMjIDAuMC4xCgotIEluaXRpYWwgdmVyc2lvbiwgY3JlYXRlZCBieSBTdGFn
ZWhhbmQK""",
  "LICENSE",
  "text",
  """Q29weXJpZ2h0IChjKSBfX3llYXJfXywgX19hdXRob3JfXy4KQWxsIHJpZ2h0cyByZXNlcnZlZC4K
ClJlZGlzdHJpYnV0aW9uIGFuZCB1c2UgaW4gc291cmNlIGFuZCBiaW5hcnkgZm9ybXMsIHdpdGgg
b3Igd2l0aG91dAptb2RpZmljYXRpb24sIGFyZSBwZXJtaXR0ZWQgcHJvdmlkZWQgdGhhdCB0aGUg
Zm9sbG93aW5nIGNvbmRpdGlvbnMgYXJlIG1ldDoKICAgICogUmVkaXN0cmlidXRpb25zIG9mIHNv
dXJjZSBjb2RlIG11c3QgcmV0YWluIHRoZSBhYm92ZSBjb3B5cmlnaHQKICAgICAgbm90aWNlLCB0
aGlzIGxpc3Qgb2YgY29uZGl0aW9ucyBhbmQgdGhlIGZvbGxvd2luZyBkaXNjbGFpbWVyLgogICAg
KiBSZWRpc3RyaWJ1dGlvbnMgaW4gYmluYXJ5IGZvcm0gbXVzdCByZXByb2R1Y2UgdGhlIGFib3Zl
IGNvcHlyaWdodAogICAgICBub3RpY2UsIHRoaXMgbGlzdCBvZiBjb25kaXRpb25zIGFuZCB0aGUg
Zm9sbG93aW5nIGRpc2NsYWltZXIgaW4gdGhlCiAgICAgIGRvY3VtZW50YXRpb24gYW5kL29yIG90
aGVyIG1hdGVyaWFscyBwcm92aWRlZCB3aXRoIHRoZSBkaXN0cmlidXRpb24uCiAgICAqIE5laXRo
ZXIgdGhlIG5hbWUgb2YgdGhlIDxvcmdhbml6YXRpb24+IG5vciB0aGUKICAgICAgbmFtZXMgb2Yg
aXRzIGNvbnRyaWJ1dG9ycyBtYXkgYmUgdXNlZCB0byBlbmRvcnNlIG9yIHByb21vdGUgcHJvZHVj
dHMKICAgICAgZGVyaXZlZCBmcm9tIHRoaXMgc29mdHdhcmUgd2l0aG91dCBzcGVjaWZpYyBwcmlv
ciB3cml0dGVuIHBlcm1pc3Npb24uCgpUSElTIFNPRlRXQVJFIElTIFBST1ZJREVEIEJZIFRIRSBD
T1BZUklHSFQgSE9MREVSUyBBTkQgQ09OVFJJQlVUT1JTICJBUyBJUyIgQU5ECkFOWSBFWFBSRVNT
IE9SIElNUExJRUQgV0FSUkFOVElFUywgSU5DTFVESU5HLCBCVVQgTk9UIExJTUlURUQgVE8sIFRI
RSBJTVBMSUVECldBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZIEFORCBGSVRORVNTIEZPUiBB
IFBBUlRJQ1VMQVIgUFVSUE9TRSBBUkUKRElTQ0xBSU1FRC4gSU4gTk8gRVZFTlQgU0hBTEwgPENP
UFlSSUdIVCBIT0xERVI+IEJFIExJQUJMRSBGT1IgQU5ZCkRJUkVDVCwgSU5ESVJFQ1QsIElOQ0lE
RU5UQUwsIFNQRUNJQUwsIEVYRU1QTEFSWSwgT1IgQ09OU0VRVUVOVElBTCBEQU1BR0VTCihJTkNM
VURJTkcsIEJVVCBOT1QgTElNSVRFRCBUTywgUFJPQ1VSRU1FTlQgT0YgU1VCU1RJVFVURSBHT09E
UyBPUiBTRVJWSUNFUzsKTE9TUyBPRiBVU0UsIERBVEEsIE9SIFBST0ZJVFM7IE9SIEJVU0lORVNT
IElOVEVSUlVQVElPTikgSE9XRVZFUiBDQVVTRUQgQU5ECk9OIEFOWSBUSEVPUlkgT0YgTElBQklM
SVRZLCBXSEVUSEVSIElOIENPTlRSQUNULCBTVFJJQ1QgTElBQklMSVRZLCBPUiBUT1JUCihJTkNM
VURJTkcgTkVHTElHRU5DRSBPUiBPVEhFUldJU0UpIEFSSVNJTkcgSU4gQU5ZIFdBWSBPVVQgT0Yg
VEhFIFVTRSBPRiBUSElTClNPRlRXQVJFLCBFVkVOIElGIEFEVklTRUQgT0YgVEhFIFBPU1NJQklM
SVRZIE9GIFNVQ0ggREFNQUdFLgo=""",
  "README.md",
  "text",
  """IyBfX3Byb2plY3ROYW1lX18KCkEgd2ViIHNlcnZlciBidWlsdCB1c2luZyBbU2hlbGZdKGh0dHBz
Oi8vcHViLmRhcnRsYW5nLm9yZy9wYWNrYWdlcy9zaGVsZikuCg==""",
  "bin/server.dart",
  "text",
  """Ly8gQ29weXJpZ2h0IChjKSBfX3llYXJfXywgX19hdXRob3JfXy4gQWxsIHJpZ2h0cyByZXNlcnZl
ZC4gVXNlIG9mIHRoaXMgc291cmNlIGNvZGUKLy8gaXMgZ292ZXJuZWQgYnkgYSBCU0Qtc3R5bGUg
bGljZW5zZSB0aGF0IGNhbiBiZSBmb3VuZCBpbiB0aGUgTElDRU5TRSBmaWxlLgoKaW1wb3J0ICdk
YXJ0OmlvJzsKCmltcG9ydCAncGFja2FnZTphcmdzL2FyZ3MuZGFydCc7CmltcG9ydCAncGFja2Fn
ZTpzaGVsZi9zaGVsZi5kYXJ0JyBhcyBzaGVsZjsKaW1wb3J0ICdwYWNrYWdlOnNoZWxmL3NoZWxm
X2lvLmRhcnQnIGFzIGlvOwoKdm9pZCBtYWluKExpc3Q8U3RyaW5nPiBhcmdzKSB7CiAgdmFyIHBh
cnNlciA9IG5ldyBBcmdQYXJzZXIoKQogICAgLi5hZGRPcHRpb24oJ3BvcnQnLCBhYmJyOiAncCcs
IGRlZmF1bHRzVG86ICc4MDgwJyk7CgogIHZhciByZXN1bHQgPSBwYXJzZXIucGFyc2UoYXJncyk7
CgogIHZhciBwb3J0ID0gaW50LnBhcnNlKHJlc3VsdFsncG9ydCddLCBvbkVycm9yOiAodmFsKSB7
CiAgICBzdGRvdXQud3JpdGVsbignQ291bGQgbm90IHBhcnNlIHBvcnQgdmFsdWUgIiR2YWwiIGlu
dG8gYSBudW1iZXIuJyk7CiAgICBleGl0KDEpOwogIH0pOwoKICB2YXIgaGFuZGxlciA9IGNvbnN0
IHNoZWxmLlBpcGVsaW5lKCkKICAgICAgLmFkZE1pZGRsZXdhcmUoc2hlbGYubG9nUmVxdWVzdHMo
KSkKICAgICAgLmFkZEhhbmRsZXIoX2VjaG9SZXF1ZXN0KTsKCiAgaW8uc2VydmUoaGFuZGxlciwg
JzAuMC4wLjAnLCBwb3J0KS50aGVuKChzZXJ2ZXIpIHsKICAgIHByaW50KCdTZXJ2aW5nIGF0IGh0
dHA6Ly8ke3NlcnZlci5hZGRyZXNzLmhvc3R9OiR7c2VydmVyLnBvcnR9Jyk7CiAgfSk7Cn0KCnNo
ZWxmLlJlc3BvbnNlIF9lY2hvUmVxdWVzdChzaGVsZi5SZXF1ZXN0IHJlcXVlc3QpIHsKICByZXR1
cm4gbmV3IHNoZWxmLlJlc3BvbnNlLm9rKCdSZXF1ZXN0IGZvciAiJHtyZXF1ZXN0LnVybH0iJyk7
Cn0K""",
  "pubspec.yaml",
  "text",
  """bmFtZTogJ19fcHJvamVjdE5hbWVfXycKdmVyc2lvbjogMC4wLjEKZGVzY3JpcHRpb246IEEgd2Vi
IHNlcnZlciBidWlsdCB1c2luZyB0aGUgc2hlbGYgcGFja2FnZS4KI2F1dGhvcjogX19hdXRob3Jf
XyA8ZW1haWxAZXhhbXBsZS5jb20+CiNob21lcGFnZTogaHR0cHM6Ly93d3cuZXhhbXBsZS5jb20K
CmVudmlyb25tZW50OgogIHNkazogJz49MS4wLjAgPDIuMC4wJwoKZGVwZW5kZW5jaWVzOgogIGFy
Z3M6ICc+PTAuMTAuMCA8MC4xNC4wJwogIHNoZWxmOiAnPj0wLjYuMCA8MC43LjAnCg=="""
];
