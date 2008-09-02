//
//      srecord - manipulate eprom load files
//      Copyright (C) 1998, 1999, 2001-2003, 2006-2008 Peter Miller
//
//      This program is free software; you can redistribute it and/or modify
//      it under the terms of the GNU General Public License as published by
//      the Free Software Foundation; either version 3 of the License, or
//      (at your option) any later version.
//
//      This program is distributed in the hope that it will be useful,
//      but WITHOUT ANY WARRANTY; without even the implied warranty of
//      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//      GNU General Public License for more details.
//
//      You should have received a copy of the GNU General Public License
//      along with this program. If not, see
//      <http://www.gnu.org/licenses/>.
//

#ifndef LIB_SREC_OUTPUT_H
#define LIB_SREC_OUTPUT_H

#include <cstdarg>
#include <string>
#include <boost/shared_ptr.hpp>

#include <lib/format_printf.h>

class srec_arglex; // forward
class srec_record; // forward

/**
  * The srec_output class is used to represent an abstract output vector.
  * It could be a file, it could be a filter first, before it reaches
  * a file.
  */
class srec_output
{
public:
    typedef boost::shared_ptr<srec_output> pointer;

    /**
      * The destructor.
      */
    virtual ~srec_output();

    /**
      * The write method is used to write a recordonto an output.
      * Derived classes must implement this method.
      */
    virtual void write(const srec_record &) = 0;

    /**
      * The write_header method is used to write a header record
      * to the output.  If no record is specified, a default
      * record will be supplied.  The write method will be called.
      */
    virtual void write_header(const srec_record * = 0);

    /**
      * The write_data method is used to write data to the output.
      * A suitable data record wil be produced.  The write method
      * will be called.
      */
    virtual void write_data(unsigned long, const void *, size_t);

    /**
      * The write_execution_start_address method is used to write an
      * execution start address record to the output.  If no record is
      * specified, a default record will be supplied.  The write method
      * will be called.
      */
    virtual void write_execution_start_address(const srec_record * = 0);

    /**
      * The set_line_length method is used to set the maximum
      * length of an output line, for those formats for which
      * this is a meaningful concept, and the line length is at
      * all controllable.  Derived classes must implement this method.
      */
    virtual void line_length_set(int) = 0;

    /**
      * The address_length_set method is used to set the minimum
      * number of bytes to be written for addresses in the output,
      * for those formats for which this is a meaningful concept, and
      * the address length is at all controllable.      Derived classes
      * must implement this method.
      */
    virtual void address_length_set(int) = 0;

    /**
      * The preferred_block_size_get method is used to get the
      * proferred block size of the output fformat.  Often, but not
      * always, influenced by the line_lebgth_set method.  Derived
      * classes must implement this method.
      */
    virtual int preferred_block_size_get() const = 0;

    /**
      * The fatal_error method is used to report fatal errors.
      * The `fmt' string is in the same style a standard C printf
      * function.  It calls the fatal_error_v method.  This method
      * does not return.
      */
    virtual void fatal_error(const char *fmt, ...) const
                                                        FORMAT_PRINTF(2, 3);
    /**
      * The fatal_error_v method is used to report fatal errors.
      * The `fmt' string is in the same style a standard C vprintf
      * function.  It calls ::exit.  This method does not return.
      */
    virtual void fatal_error_v(const char *fmt, va_list ap) const;

    /**
      * The fatal_error_errno method is used to report fatal errors,
      * and append the string equivalent of errno.  The `fmt' string
      * is in the same style a standard C printf function.  It calls
      * ::exit().  This method does not return.
      */
    virtual void fatal_error_errno(const char *fmt, ...) const
                                                        FORMAT_PRINTF(2, 3);
    /**
      * The fatal_error_errno_v method is used to report fatal
      * errors.  The `fmt' string is in the same style a standard C
      * vprintf function.  It calls the ::exit function.
      * This method does not return.
      */
    virtual void fatal_error_errno_v(const char *fmt, va_list ap) const;

    /**
      * The warning method is used to likely but non-fatal errors.
      * The `fmt' string is in the same style a standard C printf
      * function.  It calls the warning_v method.
      */
    virtual void warning(const char *fmt, ...) const
                                                        FORMAT_PRINTF(2, 3);
    /**
      * The warning_v method is used to report likely but non-fatal
      * errors.  The `fmt' string is in the same style a standard
      * C vprintf function.
      */
    virtual void warning_v(const char *fmt, va_list ap) const;

    /**
      * The filename method is used to determine the name of the
      * output file.  It is used for the various error messages.
      * Derived classes must implement this method.
      */
    virtual const std::string filename() const = 0;

    /**
      * The format_name method is used to obtain the name of this output
      * format.
      */
    virtual const char *format_name() const = 0;

    /**
      * The notify_upper_bound method is used to notify the output class
      * of the upper bound (highest address plus one) of the output
      * to come.  Shall be called before the hread or any data records
      * are written.
      */
    virtual void notify_upper_bound(unsigned long addr);

    /**
      * The command_line method is used by arglex_srec::get_output when
      * parsing the command line, to give the format an opportunity
      * to grab extra arguments off the command line.  The default
      * implementation does nothing.
      *
      * @param cmdln
      *     Where to obtain information about the curreent parse stat of
      *     the command line.
      */
    virtual void command_line(srec_arglex *cmdln);

protected:
    /**
      * The default constructor.  Only dervived classes may use.
      */
    srec_output();

private:
    /**
      * The copy constructor.  Do not use.
      */
    srec_output(const srec_output &);

    /**
      * The assignment operator.  Do not use.
      */
    srec_output &operator=(const srec_output &);
};

#endif // LIB_SREC_OUTPUT_H
