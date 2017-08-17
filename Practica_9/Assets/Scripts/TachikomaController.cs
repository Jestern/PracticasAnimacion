using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TachikomaController : MonoBehaviour {

    private GameObject obj;

	// Use this for initialization
	void Start () {
        this.obj = GameObject.Find("p8_no_anim");
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.LeftControl) || Input.GetKeyDown(KeyCode.RightControl)) {
            this.obj.GetComponent<Animation>().CrossFade("t_anim_01");
        } else if(Input.GetKeyDown(KeyCode.T)) {
            this.obj.GetComponent<Animation>().CrossFade("t_anim_02");
        }
	}
}
