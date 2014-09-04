//==============================================
//  rehearsal marks sequencer v0.1
//
//  Copyright (C)2014 Jörn Eichler (heuchi) 
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//==============================================

import QtQuick 2.0
import MuseScore 1.0

MuseScore {
      menuPath: "Plugins.rehearsalMarkSeq"

      // aray not using I, J, and O
      property var letterArray: ["A","B","C","D","E","F","G","H","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z",
                                             "Aa","Bb","Cc","Dd","Ee","Ff","Gg","Hh","Kk","Ll","Mm","Nn","Pp","Qq","Rr","Ss","Tt",
                                             "Uu","Vv","Ww","Xx","Yy","Zz"]; // if this is not enough, use numbers!
      // array also using I, J and O
      property var fullLArray:  ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
                                             "Aa","Bb","Cc","Dd","Ee","Ff","Gg","Hh","Ii","Jj","Kk","Ll","Mm","Nn","Oo","Pp","Qq","Rr","Ss","Tt",
                                             "Uu","Vv","Ww","Xx","Yy","Zz"]; // if this is not enough, use numbers!

      // if useNumbers is true we use the index variable and write numbers
      // if useNumbers is false we use the useArray and if index exceeds the length we reuse the array

      property bool useNumbers: false;
      property var useArray: letterArray;

      // first value to use
      property var startIndex: 35;

      function rehearsalMarks() {
            // find selection
            var endTick;
            var segment;
            var cursor = curScore.newCursor();

            cursor.rewind(1);
            if (cursor.segment) {
                  cursor.rewind(2);
                  if (cursor.tick == 0) {
                        endTick = curScore.lastSegment.tick + 1;
                  } else {
                        endTick = cursor.tick;
                  }
                  cursor.rewind(1);
            } else {
                  endTick = curScore.lastSegment.tick + 1;
                  cursor.rewind(0);
            }

            segment = cursor.segment;

            var index=startIndex;

            while (segment && segment.tick < endTick) {
                  // get annotations
                  var annotations = segment.annotations;

                  // look for rehearsal mark
                  if (annotations && annotations.length >0) {
                        for (var i=0; i<annotations.length;i++) {
                              var mark = annotations[i];
                              if (mark.type == Element.REHEARSAL_MARK) {
                                    // found rehearsal mark
                                    if (useNumbers) {
                                          // using numbers
                                          mark.text = index++;
                                    } else {
                                          // using array
                                          mark.text = useArray[index++];
                                          if (index >= useArray.length) {
                                                // cycle
                                                index = 0;
                                          }
                                    }
                              }
                        }
                  }
                  segment = segment.next;
            }
      }

      onRun: {
            rehearsalMarks();
            Qt.quit()
            }
      }
