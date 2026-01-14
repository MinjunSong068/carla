// Copyright (c) 2022 Computer Vision Center (CVC) at the Universitat Autonoma
// de Barcelona (UAB).
//
// This work is licensed under the terms of the MIT license.
// For a copy, see <https://opensource.org/licenses/MIT>.

#pragma once

#include <cstdint>

namespace carla {
namespace multigpu {

enum MultiGPUCommand : uint32_t {
  SEND_FRAME = 0,
  LOAD_MAP,
  GET_TOKEN,
  ENABLE_ROS,
  DISABLE_ROS,
  IS_ENABLED_ROS,
  YOU_ALIVE
};

struct CommandHeader {
  MultiGPUCommand id;
  uint32_t size;
};

} // namespace multigpu
} // namespace carla


//from CarlaEngine.cpp
// switch (Id) {
//           case carla::multigpu::MultiGPUCommand::SEND_FRAME:
//           {
//             if(GetCurrentEpisode())
//             {
//               TRACE_CPUPROFILER_EVENT_SCOPE_STR("MultiGPUCommand::SEND_FRAME");
//               // convert frame data from buffer to istream
//               CarlaStreamBuffer TempStream((char *) Data.data(), Data.size());
//               std::istream InStream(&TempStream);
//               GetCurrentEpisode()->GetFrameData().Read(InStream);
//               {
//                 TRACE_CPUPROFILER_EVENT_SCOPE_STR("FramesToProcess.emplace_back");
//                 std::lock_guard<std::mutex> Lock(FrameToProcessMutex);
//                 FramesToProcess.emplace_back(GetCurrentEpisode()->GetFrameData());
//               }
//             }
//             // forces a tick
//             Server.Tick();
//             break;
//           }
//           case carla::multigpu::MultiGPUCommand::LOAD_MAP:
//           {
//             FString FinalPath((char *) Data.data());
//             UGameplayStatics::OpenLevel(CurrentEpisode->GetWorld(), *FinalPath, true);
//             break;
//           }
//           case carla::multigpu::MultiGPUCommand::GET_TOKEN:
//           {
//             // get the sensor id
//             auto sensor_id = *(reinterpret_cast<carla::streaming::detail::stream_id_type *>(Data.data()));
//             // query dispatcher
//             carla::streaming::detail::token_type token(Server.GetStreamingServer().GetToken(sensor_id));
//             carla::Buffer buf(reinterpret_cast<unsigned char *>(&token), (size_t) sizeof(token));
//             carla::log_info("responding with a token for port ", token.get_port());
//             Secondary->Write(std::move(buf));
//             break;
//           }
//           case carla::multigpu::MultiGPUCommand::YOU_ALIVE:
//           {
//             std::string msg("Yes, I'm alive");
//             carla::Buffer buf((unsigned char *) msg.c_str(), (size_t) msg.size());
//             carla::log_info("responding is alive command");
//             Secondary->Write(std::move(buf));
//             break;
//           }
//           case carla::multigpu::MultiGPUCommand::ENABLE_ROS:
//           {
//             // get the sensor id
//             auto sensor_id = *(reinterpret_cast<carla::streaming::detail::stream_id_type *>(Data.data()));
//             // query dispatcher
//             Server.GetStreamingServer().EnableForROS(sensor_id);
//             // return a 'true'
//             bool res = true;
//             carla::Buffer buf(reinterpret_cast<unsigned char *>(&res), (size_t) sizeof(bool));
//             carla::log_info("responding ENABLE_ROS with a true");
//             Secondary->Write(std::move(buf));
//             break;
//           }
//           case carla::multigpu::MultiGPUCommand::DISABLE_ROS:
//           {
//             // get the sensor id
//             auto sensor_id = *(reinterpret_cast<carla::streaming::detail::stream_id_type *>(Data.data()));
//             // query dispatcher
//             Server.GetStreamingServer().DisableForROS(sensor_id);
//             // return a 'true'
//             bool res = true;
//             carla::Buffer buf(reinterpret_cast<unsigned char *>(&res), (size_t) sizeof(bool));
//             carla::log_info("responding DISABLE_ROS with a true");
//             Secondary->Write(std::move(buf));
//             break;
//           }
//           case carla::multigpu::MultiGPUCommand::IS_ENABLED_ROS:
//           {
//             // get the sensor id
//             auto sensor_id = *(reinterpret_cast<carla::streaming::detail::stream_id_type *>(Data.data()));
//             // query dispatcher
//             bool res = Server.GetStreamingServer().IsEnabledForROS(sensor_id);
//             carla::Buffer buf(reinterpret_cast<unsigned char *>(&res), (size_t) sizeof(bool));
//             carla::log_info("responding IS_ENABLED_ROS with: ", res);
//             Secondary->Write(std::move(buf));
//             break;
//           }
//         }