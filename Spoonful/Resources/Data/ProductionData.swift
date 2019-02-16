//
//  ProductionData.swift
//  Spoonful
//
//  Created by Jake Gray on 1/6/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import Foundation

class ProductionData {
    static let mainBuildings: [String] = ["Alumni House (AH)",
        "Annex (ANNEX) Architecture Building (ARCH) Art Building (ART)",
        "Biology Building (BIOL)",
        "William C. Browning Building (WBB)",
        "Building 72",
        "Building 73",
        "Buildings and Grounds (Bldg/Grd)",
        "Burbidge Athletics-Academic Center (KBAC)",
        "Business Classroom Building (BUC)",
        "Campus Store (STORE)",
        "Carolyn Tanner Irish Humanities Building (CTIHB)",
        "Central Parking Garage (CPG)",
        "C. Roland Christensen Center (CRCC)",
        "College of Law (Law)",
        "LeRoy E. Cowles Building (LCB)",
        "Dumke Family Softball Stadium",
        "Dumke Gymnastics Center (DGC)",
        "Eccles Broadcast Center (EBC)",
        "Alfred C. Emery Building (AEB)",
        "Experimental Studies Building (ESB)",
        "Eyring Chemistry Building (HEB)",
        "Fine Arts West (FAW)",
        "Film and Media Arts Building (FAMB)",
        "James Fletcher Physics Building (JFB)",
        "David P. Gardner Hall (DGH)",
        "Gardner Commons (GC)",
        "Garff Executive Education (GARFF)",
        "Donna Garff Marriott Residential Honors Scholars Community (MHC)",
        "George Thomas Building (GTB)",
        "Hedco (HEDCO)",
        "HPER East (HPR E)",
        "HPER Natatorium (HPR NAT)",
        "HPER North (HPR N)",
        "HPER West (HPR W)",
        "Huntsman Basketball Facility (HBF)",
        "Jon M. Huntsman Center (JHC)",
        "Intermountain Network Scientific Computation Center (INSCC)",
        "Rio Tinto Kennecott Mechanical Engineering Building (MEK)",
        "Kingsbury Hall (KH)",
        "Lassonde Studios (LSND)",
        "Languages and Communication (LNCO)",
        "Life Sciences Building (LS)",
        "Marriott Center for Dance (MCD)",
        "J. Willard Marriott Library (M LIB)",
        "Floyd & Jeri Meldrum Civil Engineering Building (MCE)",
        "Joseph F. Merrill Engineering Building (MEB)",
        "Motor Pool (MOTOR)",
        "Naval Science Building (NS)",
        "Northwest Parking Garage (NWPG)",
        "John R. Park Building (PARK)",
        "Performing Arts Building (PAB)",
        "South Physics Building (PHYS)",
        "Roy W. Pioneer Memorial Theatre and Elizabeth E. Simmons (PMT) Public Safety (SAFETY)",
        "Rice-Eccles Stadium (STAD)",
        "Sculpture (SCULP)",
        "Sill Center (SC)",
        "Aline Wilmot Skaggs Biology Building (ASB)",
        "Ski Team Building (SKI)",
        "Social and Behavioral Science Tower (S BEH)",
        "Social Work (SW)",
        "Beverly Taylor Sorenson Arts and Education Complex (SAEC)",
        "James LeVoy Sorenson Molecular Biotechnology Building (USTAR)",
        "Spencer Fox Eccles Business Building (SFEBB)",
        "William Stewart Building (ST)",
        "George S. Eccles Student Life Center (SLC)",
        "Student Services Building (SSB)",
        "A. Ray Olpin Student Union (UNION)",
        "Fredrick Albert Sutton Building (FASB)",
        "John Talmage Building (JTB)",
        "Thatcher Chemistry Building (TBBC)",
        "V. Randall Turpin University Services Building (VRTUSB)",
        "Utah Museum of Fine Arts (UMFA)",
        "John and Marva Warnock Engineering Building (WEB)",
        "John A. Widtsoe Building (JWB)",
        "Spence Eccles Field House (SEFH)",
        "Spence and Cleone Eccles Football Center (SCEFC)",
        "George S. Eccles Tennis Center (GETC)"].sorted()
    
    static let dormBuildings: [String] = [
        "Alliance House (615)",
        "American Indian Resource Center (AIRC)",
        "Annex",
        "Auxiliary Services Office (624)",
        "Benchmark Plaza (820)",
        "Benchmark Plaza (821)",
        "Benchmark Plaza (822)",
        "Bennion Service House (614)",
        "Cardiovascular Research Training Institute",
        "Nora Eccles Harrison (CVRTI)",
        "Chapel Glen (802)",
        "Chapel Glen (803)",
        "Chapel Glen (804)",
        "Donna Garff Marriott Residential Honors",
        "Scholars Community (MHC)",
        "Environmental Health and Safety (EHS)",
        "Fine Arts House, Emma Eccles Jones (607)",
        "First Security Business House (609)",
        "Fort Douglas Bath House (650)",
        "Fort Douglas Bowling Alley (640)",
        "Fort Douglas Commanders House (620)",
        "Fort Douglas House (602)",
        "Fort Douglas House (616)",
        "Fort Douglas House (617)",
        "Fort Douglas House (618)",
        "Fort Douglas House (621)",
        "Fort Douglas House (623)",
        "Fort Douglas House (625)",
        "Fort Douglas House (652)",
        "Fort Douglas House (653)",
        "Fort Douglas House (656)",
        "Fort Douglas House (657)",
        "Fort Douglas House (658)",
        "Fort Douglas House (660)",
        "Fort Douglas House (661)",
        "Fort Douglas House (662)",
        "Fort Douglas House (663)",
        "Fort Douglas House (664)",
        "Fort Douglas House (665)",
        "Fort Douglas House (666)",
        "Fort Douglas House (676)",
        "Fort Douglas House (Interfaith) (603)",
        "Fort Douglas Officers Club",
        "Fort Douglas PO Shops (644)",
        "Fort Douglas Public Safety (659)",
        "Fort Douglas PX (638)",
        "Gateway Heights (806)",
        "Gateway Heights (807)",
        "Heritage Center, Chase N. Peterson (H CTR)",
        "Honors Center (619)",
        "Honors Upper Division Social Justice House (606)",
        "Housing and Residential Education Office (HRE)",
        "Humanities House, O.C. Tanner (612)",
        "Kennecott House (611)",
        "Lassonde Entrepreneur Center, Pierre (PLEC)",
        "Eccles 2002 Legacy Bridge",
        "Medical Plaza North Tower (701)",
        "Medical Plaza South Tower (702)",
        "Medical Plaza Townhouses North (706)",
        "Medical Plaza Townhouses South (707)",
        "Post Chapel (648)",
        "Post Theatre (636)",
        "Poulson Honors Thesis Mentoring Community House (610)",
        "PPO Greenhouse (PPO GH)",
        "Red Butte Garden Horticulture Admin Building",
        "Red Butte Garden Amphitheater",
        "Research Administration Building (RAB)",
        "Rose House (325)",
        "S.J. Quinney Honors Law House (608)",
        "Sage Point (810)",
        "Sage Point (811)",
        "Sage Point (812)",
        "Sage Point (813)",
        "Sage Point (814)",
        "Science House, Crocker (613)",
        "Shoreline Ridge (825)",
        "Shoreline Ridge (826)",
        "Shoreline Ridge (827)",
        "Shoreline Ridge (828)",
        "Shoreline Ridge (829)",
        "Shoreline Ridge (830)",
        "Shoreline Ridge Parking Structure (SRG)",
        "Shuttle Division Offices (947)",
        "Skaggs Research (SRB)",
        "UMC House (601)",
        "University Guest House (Guest)",
        "University Surplus (627)",
        "Williams Building"
    ]
}
