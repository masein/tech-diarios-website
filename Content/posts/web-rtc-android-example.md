---
date: 2021-09-25 15:12
description: My colleague is working on WebRTC projects and so here I am sharing the two apps he developed in the past weeks with you.
tags: tech diarios, WebRTC, TexonCo, VoIP, Android, kotlin, java, LinPhone, Sip2Sip, Firebase
---

# WebRTC & VoIP Call

[Texon](https://www.linkedin.com/company/texonco) is honored to announce that our hardworking coworker, [Reza](https://www.linkedin.com/in/reza-godarzi-58b080165), in result of researching and developing different SDKs, for one of our project, has been succeeded to release two applications; *Web RTC* and *VoIP Call*!
Their use and functionality is explained in following paragraphs.


## [WebRTC](https://github.com/rezafpi008/WebRtc)


This application is specialized for peer to peer connection between 2 users or even more.

The systems used in this app are webrtc for a 2 way connection, stun to get the private ip, and firebase for sharing information in the firestore database.

### How to use:

First user,in the room name, enters a name to create a room and clicks on “Start call’’.
Second user enters the chosen name and clicks on “Join call”.
In the room, the user’s image will be in the right bottom corner and the other user will appear in the background.
Users are able to switch cameras, stop video to turn the call into voice call, mute microphone and put the voice on speaker by the buttons in the bottom.

## [VoIP Call](https://github.com/rezafpi008/VoipCall)

In this application a sip account is used and through the sdk linphone system users get connected to the sip account.
By using username, password and domain from sip account users can have a voice call or video call together.

### How to use:

Through the register page users can sign up with a name, number and a password. In the login page users need to enter the username, password and a domain server from the sip account. Then users will have to choose the type of their connection which are two: TCP and UDP.
In TCP connection type the connection will be slower than UDP but there is no frame loss.
In UDP connection type the connection will be faster than TCP but there might be some frame loss.
Users can switch cameras, stop video calls and turn the call into a voice one, mute microphone, and choose to have the sound through speakers or headset.
