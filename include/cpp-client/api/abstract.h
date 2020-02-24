/**
 * This file is part of Ark Cpp Client.
 *
 * (c) Ark Ecosystem <info@ark.io>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 **/

#ifndef ABSTRACT_H
#define ABSTRACT_H

#include "host/host.h"
#include "http/http.h"

namespace Ark {
namespace Client {
namespace API {
/**
 * Ark::Client::API::Abstract
 **/
class Abstract {
 protected:
  Host host_;
  std::unique_ptr<IHTTP> http_;
  int version_;

  Abstract(IHTTP* http, int version) : http_(http), version_(version) {}
  explicit Abstract(int version) : http_(makeHTTP()), version_(version) {}

 public:
  int version() const noexcept { return this->version_; };

  void setHost(const char* const newHost, int newPort) { this->host_.set(newHost, newPort); };
};
/**/
};  // namespace API
};  // namespace Client
};  // namespace Ark

#endif
