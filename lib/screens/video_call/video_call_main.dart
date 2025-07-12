import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late RtcEngine _engine;
  int? _remoteUid;
  bool _joined = false;
  bool _muted = false;
  bool _cameraOff = false;

  // ✅ Agora credentials
  final String appId = "a5a9fc7523634657a5173d9f4afb0d03";
  final String token =
      "007eJxTYPhgVZO/e+aSwpp3DrZ/pZey/z12tWZSOPOzToadq6M5j/5VYEg0TbRMSzY3NTI2MzYxMzVPNDU0N06xTDNJTEsySDEwbjEsymgIZGRoe3iehZEBAkF8Loa01NzU+LLMlNR8BgYAmyIjgg==";
  final String channelName = "feme_video";
  final int localUid = 0;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.camera, Permission.microphone].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(appId: appId));

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.switchCamera(); // ✅ Switch to front (selfie) camera

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          setState(() => _joined = true);
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (connection, remoteUid, reason) {
          setState(() => _remoteUid = null);
        },
      ),
    );

    await _engine.joinChannel(
      token: token,
      channelId: channelName,
      uid: localUid,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  void _toggleMute() {
    setState(() => _muted = !_muted);
    _engine.muteLocalAudioStream(_muted);
  }

  void _toggleCamera() {
    setState(() => _cameraOff = !_cameraOff);
    _engine.muteLocalVideoStream(_cameraOff);
  }

  void _switchCamera() {
    _engine.switchCamera();
  }

  Widget _remoteVideoView(int uid) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: _engine,
        canvas: VideoCanvas(uid: uid),
        connection: RtcConnection(channelId: channelName),
      ),
    );
  }

  Widget _localVideoView() {
    return _cameraOff
        ? const Center(child: Icon(Icons.videocam_off, color: Colors.white))
        : AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: _engine,
              canvas: const VideoCanvas(uid: 0),
            ),
          );
  }

  Widget _controlButton(IconData icon, VoidCallback onTap, {Color? color}) {
    return CircleAvatar(
      backgroundColor: Colors.white24,
      radius: 26,
      child: IconButton(
        icon: Icon(icon, color: color ?? Colors.white),
        onPressed: onTap,
        iconSize: 26,
      ),
    );
  }

  Widget _endCallButton() {
    return CircleAvatar(
      backgroundColor: Colors.red,
      radius: 30,
      child: IconButton(
        icon: const Icon(Icons.call_end, color: Colors.white),
        onPressed: () => Navigator.pop(context),
        iconSize: 28,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fullscreen remote video
          Positioned.fill(
            child: _remoteUid != null
                ? _remoteVideoView(_remoteUid!)
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 20),
                        Text(
                          'Waiting for other user...',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
          ),

          // Local preview (top right)
          if (_joined)
            Positioned(
              top: 40,
              right: 20,
              width: 100,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.black87,
                  child: _localVideoView(),
                ),
              ),
            ),

          // Bottom controls
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _controlButton(
                    _muted ? Icons.mic_off : Icons.mic,
                    _toggleMute,
                  ),
                  _controlButton(
                    _cameraOff ? Icons.videocam_off : Icons.videocam,
                    _toggleCamera,
                  ),
                  _controlButton(Icons.switch_camera, _switchCamera),
                  _endCallButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
