<?
//  $Name: ORG-TEST $, $Id: allseer.arrayBuilder.php,v 1.14 2002/09/02 21:35:24 leed Exp $
//---------------------------------------------------------------------
// Copyright (C) 2002 Affero, Inc.

// This file is part of The Affero Project.

// The Affero Project is free software/ you can redistribute it and/or
// modify it under the terms of the Affero General Public License as
// published by Affero, Inc./ either version 1 of the License, or
// (at your option) any later version.

// The Affero Project is distributed in the hope that it will be
// useful,but WITHOUT ANY WARRANTY/ without even the implied warranty
// of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// Affero General Public License for more details.

// You should have received a copy of the Affero General Public
// License in the COPYING file that comes with The Affero Project/ if
// not, write to Affero, Inc., 510 Third Street, Suite 225, San
// Francisco, CA 94107 USA.
//----------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////
require_once("allseer.UserSqlConn.php");

class arrayBuilder
{
    var $sqlConn= FALSE;

    function arrayBuilder() {
        if (!$this->sqlConn) {
            $this->sqlConn = new UserSqlConn;
        }
    }
//######################################################################
//    Array Building Functions start here  #############################
//  builds a single array with all competencies
    function buildLongCompetencyArray() {
        $this->arrayBuilder();
        $myResults = FALSE;
        $conn =& $this->sqlConn;

        if (!($myResults = $conn->buildCompetencyArray())) {
            $myMessaqge = "buildFormCompetencyArray() Connection error in allseer.arrayBuilders.php";
            syslog(LOG_ERR, $myMessage);

        }
        return($myResults);
    }

    //  builds a single array with all foundations
    function buildFoundations() {
        $this->arrayBuilder();
        $myResults = FALSE;
        $conn =& $this->sqlConn;

        if (!($myResults = $conn->buildFoundationArray())) {
            $myMessaqge = "buildFoundationArray() Connection error in allseer.arrayBuilders.php";
            syslog(LOG_ERR, $myMessage);

        }
        return($myResults);
    }

    ////////////////////////////////////////////////////////////////////
    //  this very specialized array is used by the expert-profile
    //  scripts.  the array allows sets of competencies to be
    //  selected from an array of UI checkboxes.  see the code in
    //  expert-profile.php and in expert-profile.tpl
    function buildFormCompetencyArray() {
        $this->arrayBuilder();
        $myResults = FALSE;
        $conn =& $this->sqlConn;

        if (!($myArray = $conn->buildCompetencyArray())) {
            $myMessaqge = "buildFormCompetencyArray() Connection error in allseer.arrayBuilders.php";
            syslog(LOG_ERR, $myMessage);

        } else {
            $k = sizeof($myArray);
            $rowMax = (int)($k / 4) + ((($k % 4) > 0) ? 1 : 0);

            for($i=0, $c=0; $i < 4; $i++) {
                for($j = 0; $j < $rowMax; $j++, $c++) {
                    $myResults[$i][$j]["cmptcy_descr"] = ($c < $k) ? $myArray[$c]["cmptcy_descr"] : "&nbsp;";
                    $myResults[$i][$j]["cmptcy_id"] = ($c < $k) ? $myArray[$c]["cmptcy_id"] : -1;
                    $myResults[$i][$j]["ctr_name"] = "FormComp-$i-$j";
                    $myResults[$i][$j]["checked"] = "OFF";
                }
            }
        }
        return(array('rows' => $rowMax, 'cols' => 4, 'ary' => $myResults));
    }

    //  builds a an array of the top rated experts for this
    //  time period $tm={"wk"|"yr"
    function buildExpertHOF($tm) {
        $this->arrayBuilder();
        $myResults = FALSE;
        $conn =& $this->sqlConn;

        if (!($myResults = $conn->readExpertHOF($tm))) {
            $myMessaqge = "readExpertHOF() Connection error in allseer.arrayBuilders.php";
            syslog(LOG_ERR, $myMessage);
        }
        //echo("<br> buildExpertHOF results:  "); var_dump($myResults);
        
        return($myResults);
    }
    //  deprecated
    function buildWeeksExpertHOF() {
        return($this->buildExpertHOF("wk"));
    }

    //  builds a an array of the top rated clients
    function buildClientHOF($tm) {
        $this->arrayBuilder();
        $myResults = FALSE;
        $conn =& $this->sqlConn;

        if (!($myResults = $conn->readClientHOF($tm))) {
            $myMessaqge = "readClientHOF() Connection error in allseer.arrayBuilders.php";
            syslog(LOG_ERR, $myMessage);
        }
        return($myResults);
    }
    //  deprecated
    function buildWeeksClientHOF() {
        return($this->buildClientHOF("wk"));
    }
    //  builds a an array of the top beneficiaries
    function buildWeeksBeneficiariesHOF() {
        $this->arrayBuilder();
        $myResults = FALSE;
        $conn =& $this->sqlConn;

        if (!($myResults = $conn->readWeeksBeneficiariesHOF())) {
            $myMessaqge = "readWeeksClientHOF() Connection error in allseer.arrayBuilders.php";
            syslog(LOG_ERR, $myMessage);
        }
        return($myResults);
    }
}

?>