#ifndef _API_INCLUDE_SENSE_H_
#define _API_INCLUDE_SENSE_H_

namespace prg {

enum Trashs { Can, Glass, Etc, General };

class Sense {
 public:
  virtual bool is_there_trash(void) = 0;
  virtual Trashs classify_trash(void) = 0;
  virtual float get_weight(void) = 0;
};

}  // namespace prg

#endif