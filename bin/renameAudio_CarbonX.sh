#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DIRNAME=$(dirname $0)

#pulseaudio -k
#pacmd set-card-profile 1 HiFi
#$DIRNAME/echoCancelEnable.sh

pacmd update-sink-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_5__sink device.description="HDMI3"
pacmd update-sink-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_4__sink device.description="HDMI2"
pacmd update-sink-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink device.description="HDMI1"
pacmd update-sink-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_5__sink device.icon_name="audio-speakers"
pacmd update-sink-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_4__sink device.icon_name="audio-speakers"
pacmd update-sink-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink device.icon_name="audio-speakers"

pacmd update-source-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_5__sink.monitor device.description="MonitorHDMI3"
pacmd update-source-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_4__sink.monitor device.description="MonitorHDMI2"
pacmd update-source-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink.monitor device.description="MonitorHDMI1"
pacmd update-source-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_5__sink.monitor device.icon_name="audio-speakers"
pacmd update-source-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_4__sink.monitor device.icon_name="audio-speakers"
pacmd update-source-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink.monitor device.icon_name="audio-speakers"

pacmd update-sink-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink device.description="Internal"
pacmd update-sink-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink device.icon_name="audio-speakers"
#pacmd update-sink-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink device.icon_name="audio-headphones"
pacmd update-source-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink.monitor device.description="MonitorInternal"
pacmd update-source-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink.monitor device.icon_name="audio-speakers"
#pacmd update-source-proplist alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink.monitor device.icon_name="audio-headphones"

pacmd update-sink-proplist echoCancel_sink device.description="EchoCanceledHDMI1"
pacmd update-sink-proplist echoCancel_sink device.icon_name="audio-speakers"
pacmd update-source-proplist echoCancel_sink.monitor device.description="MonitorEchoCanceledHDMI1"
pacmd update-source-proplist echoCancel_sink.monitor device.icon_name="audio-speakers"


pacmd update-source-proplist alsa_input.usb-046d_HD_Pro_Webcam_C920_54E2FA2F-02.iec958-stereo device.description="HDProWebcamMic"
pacmd update-source-proplist alsa_input.usb-046d_HD_Pro_Webcam_C920_54E2FA2F-02.iec958-stereo device.icon_name="camera-web"

pacmd update-source-proplist alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__source device.description="HeadphoneMic"
pacmd update-source-proplist alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__source device.icon_name="microphone-sensitivity-medium"

pacmd update-source-proplist alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_6__source device.description="InternalMic"
pacmd update-source-proplist alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_6__source device.icon_name="microphone-sensitivity-medium"

pacmd update-source-proplist echoCancel_source device.description="EchoCanceledMic"
pacmd update-source-proplist echoCancel_source device.icon_name="microphone-sensitivity-medium"
pacmd update-source-proplist echoCancel_source application.icon_name="microphone-sensitivity-medium"
